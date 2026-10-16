# Assembly

Sparky is built from the bottom up and from the back in. Do all the wiring outside the body, then slide each part into place.

## 1. Set the magnets (do this first)

Every magnet goes in with its **north face pointing up**, towards the top of the robot. That way each pair attracts.

The easy way to get it right every time:

1. Glue a magnet into a pocket on the first part.
2. Let a second magnet snap onto it.
3. Put a drop of glue in the matching pocket of the second part.
4. Press the second part onto the stacked magnet and hold for 30 seconds.

The second magnet ends up facing the correct way automatically. Mark the north faces with a marker before you start.

| Joint | Pockets |
|---|---|
| Base ↔ rack | 4 in the base top, 4 under the rack floor |
| Rack ↔ shell | 4 in the tops of the rack's two towers, 4 in the shell ceiling bosses |

## 2. Pins

Push 5 mm pieces of 1.75 mm filament into the pin holes: two on the back of the base (for the collar) and two in the front of the rack floor (for the face frame).

## 3. Load the face frame

1. **Speaker:** stand it behind the grille, cone facing forward. The stop bars hold it from behind.
2. **Display:** slide the OLED down into the groove from the top, glass facing forward, pins at the top. It stops on the shelf above the speaker.
3. Plug the display's four wires onto its pins.

## 4. Load the middle plate

1. **MPU-6050:** slide it into the groove on top from the back until it hits the front stop, chips up, header at the back.
2. **Amp:** turn the plate over and slide the amp into the groove underneath, terminal at the back. Screw the speaker wires into the terminal now.
3. Plug the jumpers onto both modules.

## 5. Load the lid

1. **Mic:** drop the round INMP441 into the pocket, chip side down, so its sound hole faces up.
2. **Touch pad:** lay the TTP223 on top at the back, pins through the slot.
3. Plug the jumpers on from underneath.

## 6. Wire it up

Follow [Wiring](wiring.md). Plug every jumper onto the expansion board, with the four Y-splitters on the shared lines, while the board is still outside.

## 7. Put it together

1. Put the collar on the base pins, then stand the **rack** in the collar; it snaps to the base.
2. Stand the **face frame** on the two floor pins at the front.
3. Slide the **board** in from the back along the floor rails, USB-C facing back, until it stops.
4. Slide the **middle plate** in from the back along the wall ledges. Feed the wires down through the plate's corner holes.
5. Optional: slide a **LiPo** into either side bay from the back and plug it into the board.
6. Drop the **lid** in between the two towers. The mic and touch wires hang down through its slots.
7. Lower the **shell** over everything; it snaps to the towers and holds the face frame, plate and lid in place.

To open it, pull the shell straight up. The lid lifts out, and everything else slides out of the back.
