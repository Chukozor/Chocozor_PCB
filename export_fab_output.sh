#!/bin/bash

FOLDER_PCB=pcb/hotswap
FOLDER_GERBER=gerber
FOLDER_PDF=pdf
FOLDER_CASE=case

mkdir -p $FOLDER_GERBER $FOLDER_PDF && \

# Export PCB and Schematic view in pdf
C:/Program\ Files/KiCad/8.0/bin/kicad-cli.exe sch export pdf -o $FOLDER_PDF/SCH.pdf $FOLDER_PCB/chocofi.kicad_sch && \
C:/Program\ Files/KiCad/8.0/bin/kicad-cli.exe pcb export pdf -o $FOLDER_PDF/PCB_TOP.pdf -l F.Cu,F.Paste,F.Silkscreen,F.Mask,Edge.Cuts --exclude-value $FOLDER_PCB/chocofi.kicad_pcb && \
C:/Program\ Files/KiCad/8.0/bin/kicad-cli.exe pcb export pdf -o $FOLDER_PDF/PCB_BOT.pdf -l B.Cu,B.Paste,B.Silkscreen,B.Mask,Edge.Cuts --exclude-value $FOLDER_PCB/chocofi.kicad_pcb

# Export .step 3D model
C:/Program\ Files/KiCad/8.0/bin/kicad-cli.exe pcb export step -o $FOLDER_CASE/PCB.step --subst-models $FOLDER_PCB/chocofi.kicad_pcb

# Export gerber folder
C:/Program\ Files/KiCad/8.0/bin/kicad-cli.exe pcb export gerbers -o $FOLDER_GERBER/ -l F.Cu,B.Cu,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,F.Mask,B.Mask,Edge.Cuts --exclude-value --no-x2 --no-netlist --subtract-soldermask $FOLDER_PCB/chocofi.kicad_pcb && \
C:/Program\ Files/KiCad/8.0/bin/kicad-cli.exe pcb export drill -o $FOLDER_GERBER/ --format excellon --excellon-separate-th --generate-map --map-format gerberx2 $FOLDER_PCB/chocofi.kicad_pcb