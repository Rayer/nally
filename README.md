# Nally

Open-Source telnet/ssh BBS client.

## History

### 1.5.0 (修改版自Rayer)

* Release date : 2019.03.10
* 增加了Google image search的功能。當選擇了一個以.jpg或者.jpeg為結尾的網址的時候，右鍵選單將會增加Search by Google Image.
* 增加了貼上Tinyurl的功能。當拷貝一個網址時，且Telnet視窗內沒有選擇任何文字時，將會有Paste by TinyURL的選項。
* 由於現在的XCode已經不支援10.6的Deployment Target，很遺憾的目前Deployment Target必須要至少macOS 10.12以上才能執行
* 同樣原因，重新編譯後原因不明有一個小Bug : 當打開了複數個BBS，滑鼠游標無法點選上面的BBS Tag，包含關閉視窗的X。請用快速鍵cmd + <- / cmd + -> / cmd + w來執行選擇左邊分頁/右邊分頁/關閉分頁的動作。

感謝前人的contribution，也希望這個open source的BBS Client能一直傳承下去。

### 1.4.9

* 修正短網址打不開的 regression
* 加入自動短網址服務選擇，例如
  	
        nxMg => ppt.cc
        YFIIB => 0rz.tw
        cbt6wym => tinyurl.com
        mid=1726264 => pixiv_member
        id=28497387 => pixiv_illust
        sm1885034 => niconico

* 修正 opt-click URL 不能在背景打開 browser 的 bug。現在可以了。
* 很遺憾，因為用了 block 所以把 deployment target 升高到 10.6。

### 1.4.8

* 修正 10.8 下藍色框的問題。
* 加入 uranusjr 貢獻的 Cmd+上下鍵對應到 PageUp/PageDown。
* 打開 URL 的一些修正。

### 1.4.7

* 修正 crash。
* 使用 uranusjr 開發的功能，可以設定要不要用 image previewer。
* 可同時開啓多個 URL。

### 1.4.6

* 修正 Paste wrap 遇到過長英文會 hang 的 bug。
* Paste wrap 加上避頭尾點的功能。
