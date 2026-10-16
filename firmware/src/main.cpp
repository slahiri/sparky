// Sparky hardware test.
// Checks every module: animated eyes on the OLED, a beep on touch, the LED
// on a knock, and a live microphone level bar. Serial log at 115200.

#include <Arduino.h>
#include <Wire.h>
#include <U8g2lib.h>
#include <driver/i2s.h>
#include "pins.h"

// Most 1.3" modules use the SH1106. For an SSD1306 use
// U8G2_SSD1306_128X64_NONAME_F_HW_I2C instead.
U8G2_SH1106_128X64_NONAME_F_HW_I2C oled(U8G2_R0, U8X8_PIN_NONE);

static const i2s_port_t I2S_PORT = I2S_NUM_0;
static const int SAMPLE_RATE = 16000;

static bool oledFound = false;
static int micLevel = 0;            // 0..100
static uint32_t lastBlink = 0, blinkUntil = 0, happyUntil = 0, ledUntil = 0;
static int lastVibration = -1;
static bool lastTouch = false;

static void i2sInit() {
  i2s_config_t cfg = {};
  cfg.mode = (i2s_mode_t)(I2S_MODE_MASTER | I2S_MODE_TX | I2S_MODE_RX);
  cfg.sample_rate = SAMPLE_RATE;
  cfg.bits_per_sample = I2S_BITS_PER_SAMPLE_32BIT;   // INMP441 sends 24 bits in 32
  cfg.channel_format = I2S_CHANNEL_FMT_ONLY_LEFT;
  cfg.communication_format = I2S_COMM_FORMAT_STAND_I2S;
  cfg.dma_buf_count = 6;
  cfg.dma_buf_len = 256;
  cfg.tx_desc_auto_clear = true;

  i2s_pin_config_t pins = {};
  pins.mck_io_num = I2S_PIN_NO_CHANGE;
  pins.bck_io_num = PIN_I2S_BCLK;
  pins.ws_io_num = PIN_I2S_WS;
  pins.data_out_num = PIN_AMP_DIN;
  pins.data_in_num = PIN_MIC_SD;

  if (i2s_driver_install(I2S_PORT, &cfg, 0, nullptr) != ESP_OK) Serial.println("I2S install failed");
  if (i2s_set_pin(I2S_PORT, &pins) != ESP_OK) Serial.println("I2S pin setup failed");
}

// Plays a sine tone through the MAX98357A (blocking).
static void beep(float freq, int ms, float volume = 0.25f) {
  static int32_t buf[256];
  const int total = SAMPLE_RATE * ms / 1000;
  float phase = 0, step = 2.0f * PI * freq / SAMPLE_RATE;
  for (int done = 0; done < total; done += 256) {
    for (int i = 0; i < 256; i++) {
      buf[i] = (int32_t)(sinf(phase) * volume * 2147483647.0f);
      phase += step;
      if (phase > 2.0f * PI) phase -= 2.0f * PI;
    }
    size_t written;
    i2s_write(I2S_PORT, buf, sizeof(buf), &written, portMAX_DELAY);
  }
}

// Reads a block from the INMP441 and returns a rough 0..100 loudness.
static int readMicLevel() {
  static int32_t buf[256];
  size_t got = 0;
  if (i2s_read(I2S_PORT, buf, sizeof(buf), &got, pdMS_TO_TICKS(20)) != ESP_OK || got == 0) return 0;
  int32_t peak = 0;
  for (size_t i = 0; i < got / 4; i++) {
    int32_t s = abs(buf[i] >> 14);
    if (s > peak) peak = s;
  }
  return constrain(map(peak, 0, 20000, 0, 100), 0, 100);
}

static void drawFace(uint32_t now) {
  oled.clearBuffer();
  bool blinking = now < blinkUntil;
  bool happy = now < happyUntil;
  for (int side = 0; side < 2; side++) {
    int x = side == 0 ? 22 : 74;
    if (blinking)      oled.drawBox(x, 30, 32, 4);
    else if (happy)    { oled.drawDisc(x + 16, 30, 14, U8G2_DRAW_UPPER_RIGHT | U8G2_DRAW_UPPER_LEFT); }
    else               oled.drawRBox(x, 12, 32, 34, 8);
  }
  oled.drawFrame(14, 56, 100, 6);                     // mic level bar
  oled.drawBox(14, 56, micLevel, 6);
  oled.sendBuffer();
}

void setup() {
  Serial.begin(115200);
  pinMode(PIN_TOUCH, INPUT);
  pinMode(PIN_VIBRATION, INPUT);
  pinMode(PIN_LED, OUTPUT);

  Wire.begin(PIN_OLED_SDA, PIN_OLED_SCL);
  Wire.beginTransmission(0x3C);                       // u8g2 does not report a missing display
  oledFound = Wire.endTransmission() == 0;
  Serial.printf("OLED %s at 0x3C\n", oledFound ? "found" : "NOT found");
  if (oledFound) {
    oled.setBusClock(400000);
    oled.begin();
  }

  i2sInit();
  digitalWrite(PIN_LED, HIGH);
  beep(660, 90);
  beep(990, 120);
  digitalWrite(PIN_LED, LOW);
  Serial.println("Sparky hardware test ready: touch = beep, knock = LED, talk = level bar");
}

void loop() {
  uint32_t now = millis();

  bool touch = digitalRead(PIN_TOUCH) == HIGH;
  if (touch && !lastTouch) {
    Serial.println("Touch");
    happyUntil = now + 1500;
    beep(880, 120);
  }
  lastTouch = touch;

  int vib = digitalRead(PIN_VIBRATION);
  if (lastVibration >= 0 && vib != lastVibration) {
    Serial.println("Knock");
    ledUntil = now + 300;
  }
  lastVibration = vib;
  digitalWrite(PIN_LED, now < ledUntil ? HIGH : LOW);

  micLevel = (micLevel * 3 + readMicLevel()) / 4;

  if (now - lastBlink > 3500) { lastBlink = now; blinkUntil = now + 140; }
  if (oledFound) drawFace(now);
}
