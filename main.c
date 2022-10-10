#include <posapi.h>
#include <posapi_all.h>

//#define PROLIN_OS_APP     //for monitor App on prolin system
#ifndef PROLIN_OS_APP
const APPINFO AppInfo = {
#else
const APPINFO_SECTION APPINFO AppInfo = {
#endif

	"POS-Simple example",
	"APP_TEST", // for Prolin OS,this item can not contain " -+= "(special character)
	"1.0",
	"pcteam",
	"demo program",
	"",
	0,
	0,
	0,
	""};

int event_main(ST_EVENT_MSG *msg)

{
	SystemInit();
	return 0;
}

int main(void)
{
	int iRet;
	char ucFileName[40] = "appD188.bin";

	iRet = FileToApp(ucFileName);
	ScrPrint(0, 4, ASCII, "FileToApp(%s, %d)\n", ucFileName, iRet);

}

