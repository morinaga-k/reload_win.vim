#include <windows.h>
#include <tchar.h>
#include <string.h>

HWND hTarget;
HWND hMe[50];
char IeFlg = 0;

void add(HWND hwnd) {
	static char addi = 0;
	hMe[addi] = hwnd;
	++addi;
}

BOOL CALLBACK callback(HWND hwnd, LPARAM lparam) {
	char buf[521];
	char *sp;
	GetWindowText(hwnd, buf, sizeof(buf));
	if ((sp = strstr(buf, "Chrome")) != NULL ||
			(sp = strstr(buf, "Internet Explorer")) != NULL ||
			(sp = strstr(buf, "Firefox")) != NULL ||
			(sp = strstr(buf, "Opera")) != NULL ||
			(sp = strstr(buf, "Safari")) != NULL) {
		hTarget = hwnd;
		if (strcmp(sp, "Internet Explorer") == 0) {
			IeFlg = 1;
		}
	}
	if (strstr(buf, "VIM") != NULL) {
		add(hwnd);
	}

	return TRUE;
}

int WINAPI WinMain(HINSTANCE hInst, HINSTANCE hPrevInst, LPSTR pCmdLine, int showCmd) {

	EnumWindows(callback, 0);

	SetForegroundWindow(hTarget);
	if (!IeFlg) {
		keybd_event(VK_BROWSER_REFRESH, 0, 0, 0);
	} else {
		keybd_event(VK_F5, 0, 0, 0);
	}

	SetForegroundWindow(hMe[0]);
	SetWindowPos(hMe[0], HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE | SWP_SHOWWINDOW);

	return 0;
}

