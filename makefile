
LOCSRC  = C:\PAXPAY~1\myapp\UPDATE~1
LOCOBJ  = C:\PAXPAY~1\myapp\UPDATE~1
GCCDIR = C:\PAXPAY~1\build\gcc-arm-none-eabi
LOCINC  = -I. -I$(GCCDIR)\..\build\gcc-arm-none-eabi\lib\gcc\arm-none-eabi\4.7.3\include -I$(GCCDIR)\..\postype\D188\include  -IC:\PAXPAY~1\include -IC:\PAXPAY~1\include
POSLIBDIR = C:\PAXPAY~1\postype\D188
TARGET = C:\PAXPAY~1\myapp\UPDATE~1\UpdateTestD188
OBJ       =          $(LOCOBJ)\main.o

APPAPI	= D188api
GCCBIN = $(GCCDIR)\bin\arm-none-eabi-
GCCLIBDIR = $(GCCDIR)\lib
CC = $(GCCBIN)gcc
AS = $(GCCBIN)as
AR = $(GCCBIN)ar
LD = $(GCCBIN)ld
OBJDUMP = $(GCCBIN)objdump
OBJCOPY = $(GCCBIN)objcopy
STRIP = $(GCCBIN)strip
LD_GEN = $(POSLIBDIR)\LD_Gen.exe
LDFILE_TEMPLET = $(POSLIBDIR)\mldscript_t
LDFILE = $(POSLIBDIR)\mldscript

#ASFLAG = $(LOCINC) -mcpu=cortex-m3 -mthumb
LDFLAG = -M -T$(LDFILE) -L$(POSLIBDIR) -L$(GCCLIBDIR) --gc-sections -nostartfiles -nostd
CFLAG  = $(LOCINC) $(PREDEFINE) -std=gnu99 -mcpu=cortex-m3 -mthumb -ffunction-sections -fdata-sections -Os -mlittle-endian  -msoft-float -Wall -fstack-usage -funsigned-char -Wno-implicit-function-declaration -D_D188_POS 
GCC = $(CC) -c $(CFLAG)
LIBS =  --start-group -l$(APPAPI)  -lc -lgcc -lnosys --end-group

.PHONY: clean all
all: $(TARGET).elf

$(TARGET).elf : $(OBJ) 
	$(LD_GEN) $(LDFILE_TEMPLET) $(LDFILE)
	$(LD) $(LDFLAG) -o $@ $(OBJ) $(LIBS) > nul
	$(OBJCOPY) -O binary $@ $(TARGET)

	$(LD_GEN) $(LDFILE_TEMPLET) $(LDFILE) $(TARGET)
	$(LD) $(LDFLAG) -o $@ $(OBJ) $(LIBS) > $(TARGET).map
	$(OBJCOPY) -O binary $@ $(TARGET).bin
	$(OBJDUMP) -D -S $@ > $(TARGET).dasm
	copy /b $(TARGET).bin+$(LOCOBJ)\app.tag $(TARGET).bin
	@del $(TARGET) 1>nul 2>nul
	@echo   "------------DONE!------------"

$(LOCOBJ)\main.o: "C:\PAXPAY~1\myapp\UPDATE~1\main.c"
        $(GCC) "C:\PAXPAY~1\myapp\UPDATE~1\main.c" -o $(LOCOBJ)\main.o


clean:
	@echo   "Start Clean...."
	@del $(TARGET).bin 1>nul 2>nul
#	@del /q *.o 1>nul 2>nul
#	@del /q *.su 1>nul 2>nul
	@del /q *.map 1>nul 2>nul
	@del /q *.elf 1>nul 2>nul
	@echo   "Clean Done"
