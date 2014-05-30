TODAY=$(shell date +'%Y%m%d')


ifeq (eagle, )
	EAGLE=/Applications/EAGLE-6.5.0/EAGLE.app/Contents/MacOS/EAGLE
else
	EAGLE=eagle
endif


LAYERS=2

all: $(PROJECT).zip
	@ echo


prepare: $(PROJECT).brd
	@ echo "***** Preparing labels ($(TAG)-$(HASH)-$(TODAY)) *****"
	@cp $(PROJECT).brd $(PROJECT).cp.brd
	
	@sed -i '' "s/REVISION/$(TAG) $(HASH)/g" $(PROJECT).cp.brd
	@sed -i '' "s/DATE/$(TODAY)/g" $(PROJECT).cp.brd

gerbers: prepare
	@ echo "***** Generating Gerber Files for $(PROJECT) *****"
	@$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).GTL $(PROJECT).cp.brd Top Pads Vias Dimension 	> /dev/null 	# Top Copper
	@$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).GBL $(PROJECT).cp.brd Bottom Pads Vias	> /dev/null 			# Bottom Copper
	@$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).GTO $(PROJECT).cp.brd tPlace tNames tValues > /dev/null 		# Top Silk
	@$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).GBO $(PROJECT).cp.brd bPlace bNames bValues > /dev/null 		# Bottom Silk
	@$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).GTP $(PROJECT).cp.brd tCream > /dev/null 						# Top Paste
	@$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).GBP $(PROJECT).cp.brd bCream > /dev/null 						# Bottom Paste
	@$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).GTS $(PROJECT).cp.brd tStop > /dev/null 						# Top Soldermask
	@$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).GBS $(PROJECT).cp.brd bStop > /dev/null 						# Bottom Soldermask
	@$(EAGLE) -X -dEXCELLON -o$(PROJECT)-$(TAG).TXT $(PROJECT).cp.brd Drills Holes > /dev/null 						# Drill File
	@$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).GML $(PROJECT).cp.brd Milling > /dev/null 						# Mill Layer
	# @$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).Docu $(PROJECT).cp.brd Perf Document Reference > /dev/null 		# Docu/perfs


ifeq ($(LAYERS), 4)
		@ echo "***** Generating Internal Layer Gerber Files for $(PROJECT) *****"
		@$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).G1 $(PROJECT).cp.brd VCCPlane Pads Vias > /dev/null
		@$(EAGLE) -X -dGERBER_RS274X -o$(PROJECT)-$(TAG).G2 $(PROJECT).cp.brd GroundPlane Pads Vias > /dev/null
endif

$(PROJECT).zip: gerbers
	@ echo "***** Moving Gerbers to gerbers/$(PROJECT)-$(TAG)-$(TODAY) *****"
	@mkdir -p gerbers/$(PROJECT)-$(TAG)-$(TODAY)
ifeq ($(LAYERS), 4)
	@mv $(PROJECT)-$(TAG).{GTL,GBL,GTO,GBO,GTP,GBP,GTS,GBS,TXT,GML,G1,G2} gerbers/$(PROJECT)-$(TAG)-$(TODAY)
	@# zip gerbers/$(PROJECT)/Livestream-$(PROJECT)-$(TAG)-$(HASH)-$(TODAY).zip gerbers/$(PROJECT)/*.{GTL,GBL,GTO,GBO,GTP,GBP,GTS,GBS,TXT,GML,G1,G2}
else
	@mv $(PROJECT)-$(TAG).{GTL,GBL,GTO,GBO,GTP,GBP,GTS,GBS,TXT,GML} gerbers/$(PROJECT)-$(TAG)-$(TODAY)
	@# zip gerbers/$(PROJECT)/Livestream-$(PROJECT)-$(TAG)-$(HASH)-$(TODAY).zip gerbers/$(PROJECT)/*.{GTL,GBL,GTO,GBO,GTP,GBP,GTS,GBS,TXT,GML}
endif

 
view: $(PROJECT).zip
	gerbv gerbers/$(PROJECT)/$(PROJECT).{GTL,GBL,GTO,GBO,GTP,GBP,GTS,GBS,TXT,GML,G1,G2} &
 
clean:
ifdef PROJECT
	rm -rf gerbers/$(PROJECT)-$(TAG)-$(TODAY)
endif
	rm -rf *.{GTL,GBL,GTO,GBO,GTP,GBP,GTS,GBS,TXT,GML,G1,G2,zip,png,path,dri,gpi}
	rm -rf *.cp.brd

cleanall:
	rm -rf *.{GTL,GBL,GTO,GBO,GTP,GBP,GTS,GBS,TXT,GML,G1,G2,zip,png,path,dri,gpi}
	rm -rf *.cp.brd
	rm -rf gerbers

.PHONY: clean cleanall gerbers