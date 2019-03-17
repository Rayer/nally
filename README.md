# Nally

Open-Source telnet/ssh BBS client.

## Issue Tracking

[YouTrack追蹤頁面](https://irisnode.myjetbrains.com/youtrack/)顯示了所有的開發中項目，如果有issue回報或者新功能request，請在GitHub的issue發出，接受後會移到YouTrack。

## History

### 2.0.0

Release Date : 2019.03.18

這個版本暫時來說是最後一個版本了，已經把所有本來想要增加的功能都增加上去了。

* Smart Paste(智慧拼貼) : 按下功能列右上角的"S"按鈕啟動。Smart Paste在剪貼簿裡面的資料合乎如下條件時，貼上(⌘+V)時會替使用者做如下的轉換：
	- 當剪貼簿裡面是一個URL時，如果URL的長度大於40個字元，會自動幫使用者貼上TinyURL縮址過的網址。
	- 當剪貼簿裡面是圖形資料時(通常是來自於使用者使用Mac風格的畫面擷取: `⌘+shift+ctrl+3` 或者 `⌘+shift+ctrl+4`)，會幫使用者自動上傳上Imgur並且貼上Imgur網址。
	- 當剪貼簿裡面是圖像檔案時(通常來自於對圖形檔案`⌘+C`，或者對Photos App的照片`⌘+C`等等)，同樣會自動上傳上Imgur並且貼上Imgur網址。
	- 其他情況下，本來行為是什麼就是什麼。

### 1.5.2

Release date : 2019.03.17

- 當貼上imgur或者試圖產生tinyurl時，會有一個視窗告訴你現在正在做甚麼以及防止在這動作完成以前繼續貼圖或者貼網址。
- 現在可以直接cmd-c任何圖案以後直接貼上imgur了，同樣的按下右鍵選擇「貼上imgur」即可


### 1.5.1

Release date : 2019.03.13

#### 對使用者來說

* 增加了更多的Search image by Google的格式，現在`.tiff`, `.png`以及`.gif`都可以被image search了。
* 現在支援了paste to imgur，只要使用傳統的Mac剪貼螢幕到剪貼簿的快速鍵(`shift-ctrl-cmd-3`跟`shift-ctrl-cmd-4`)剪貼下來的圖案，現在可以從右鍵選單直接送上imgur並且回傳網址。
	* 不過`cmd+c`直接拷貝照片目前無法送上imgur，這會在下個版本推出。
	* 按下Post to Imgur以後需要一點時間網址才會傳回來，大概一兩秒，這段時間bbs view仍然可以操作...會造成貼到意料之外的地方。
	* 但是我覺得直接block讓他轉圈圈也不是好主意，沒辦法。

#### 對開發者來說

* 增加了CocoaPods的支援。
* 增加了TravisCI的支援，但是由於CocoaPods加入以後組態搞不定，所以目前還是壞掉的狀態。
* 現在應該可以在XCode10底下編譯了。SDK10.12~10.14都測過，應該沒啥問題。

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
