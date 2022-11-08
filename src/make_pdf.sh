#!/usr/bin/env bash
#
# PDF report for registration/scaling

# Brain extraction (for intensity scaling PDF views)
# Estimate it with the PD where contrast isn't strange
bet rpd brain -R -m

# Brain intensity scaling factors for viewing
mscl=$(fslstats mrt1 -k brain_mask -p 99)
smscl=$(fslstats smrt1 -k brain_mask -p 99)

# Mean T1 unscaled
fsleyes render -of mrt1.png -sz 900 300 \
    --scene ortho --displaySpace world --hideCursor -lo horizontal \
    mrt1 -ot volume -dr 0 ${mscl} \
    brain_mask -ot mask -mc 0.3 0.5 0.8 -o -w3

# Mean T1 scaled
fsleyes render -of smrt1.png -sz 900 300 \
    --scene ortho --displaySpace world --hideCursor -lo horizontal \
    smrt1 -ot volume -dr 0 ${smscl} \
    brain_mask -ot mask -mc 0.3 0.5 0.8 -o -w3

# Combine
convert \
    -size 1275x1650 xc:white \
    -gravity center \( mrt1.png -resize 1000 -geometry +0-200 \) -composite \
    -gravity center \( smrt1.png -resize 1000 -geometry +0+200 \) -composite \
    -gravity North -pointsize 48 -annotate +0+200 \
        "Mean T1 (top) and scaled by PD (bottom)" \
    prept1.pdf



