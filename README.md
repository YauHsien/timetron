# timetron
Time-keeper for distributed systems

## 情況確認
#### 規格
以下打問號的點為規格要項，其餘為平白敘述。
- 是否能取得時間？
  - UTC 時間正確 = 時區時間正確
  - UTC 時間正確 -> （表示） 時間正確
  - 時區時間正確 -> 時間正確
  - 時間正確 -> 瀏覽器 HTTPS 順暢
  - 故若瀏覽器 HTTPS 順暢
  - 則時間正確
- 能找到同儕節點 -> 能進行網路通訊
  - 是否能找到 Time server ？
    - 能連通網路 -> 能找到 NTP server 取得時間
    - 故若能找到 NTP server
    - 則能連通網路。
  - 是否能找到同儕節點？
    - <strike>能連通網路 -> 能找到 NTP server 取得時間</strike>
    - 能連通網路，且網段有同儕節點 -> 能找到同儕節點 
    - 故若能<strike>找到 NTP server，且</strike>找到同儕節點
    - 則能連通網路
    - 且網段有同儕節點
- 系統有多節點，節點之間互相傳遞訊息；其中一種訊息為 LLU (Low-level update) ，包含時間校正資訊。
- 演算法：
  - 環境：節點與其他節點通訊互動，透過 LLU 由外來節點傳入訊息，並由節點向外傳出訊息。
  - 動作者：本節點
  - 結果：訊息將可能使節點重新配置時間。
  - 輸入與輸出：無
  - 訊息傳入與傳出： `{ universal t | local t [, n ] }`
  - 特性：若二個同儕節點都無法取得 UTC 時間，則無法互相協助校正時間。
  - 傳出訊息的步驟：
    1. 若找到 NTP server ：讀取 UTC 時間 t<sub>1</sub>。
       1. 讀取本機 UTC 日期與時間 t<sub>2</sub> 。
       1. 如果 t<sub>1</sub> 對 t<sub>2</sub> 有落差，則對本機節點傳送訊息 <pre>universal t<sub>1</sub></pre>
       1. 對同儕節點傳遞 <pre>universal t<sub>1</sub></pre>
    1. 若找不到 NTP server 但找得到同儕節點：
       1. 讀取本機 UTC 日期與時間 t 。
       1. 取得節點代號 n 。
       1. 對同儕節點傳遞 `local t, n` 。
  - 傳入訊息的步驟：
    1. 若收到傳入訊息 `universal t`
       1. 讀取本機 UTC 日期與時間 t<sub>1</sub> 。
       1. 如果 t 對 t<sub>1</sub> 有落差，則對本機節點傳送訊息 <pre>universal t<sub>1</sub></pre>
    1. 若收到傳入訊息 `local t, n`
       1. 若找到 NTP server ：讀取 UTC 時間 t<sub>1</sub>。
          1. 如果 t 對 t<sub>1</sub> 有落差，則對本機節點傳送訊息 <pre>universal t<sub>1</sub></pre>
          1. 對同儕節點 n 傳遞 <pre>universal t<sub>1</sub></pre>
       1. 若找不到 NTP server 但找得到同儕節點：
          - （空缺）

### Erlang UTC
```Erlang
    calendar:universal_time().
```
### 瀏覽器對無效時間的反應
由於 TLS 對憑證時間敏感。
![image](https://github.com/YauHsien/timetron/assets/595388/ac60be8f-4d2e-416a-88aa-3431a9ca3681)

## 檔案結構
- 名稱：軟體類別
- 第一層：通盤說明
  - 第二層：實作語言與語言專屬的資源

## References
- w32tm
- NTP
- [NTP Pool project](https://www.ntppool.org/en/use.html)
- Erlang:
  - [Time correction in Erlang](https://www.erlang.org/doc/apps/erts/time_correction)
