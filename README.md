# timetron
Time-keeper for distributed systems

## 情況確認
#### 規格
- 是否能取得時間？
  - UTC 時間正確 = 時區時間正確
  - UTC 時間正確 -> 時間正確
  - 時區時間正確 -> 時間正確
  - 時間正確 -> 瀏覽器 HTTPS 順暢
  - 故若瀏覽器 HTTPS 順暢
  - 則時間正確
- 能找到同儕節點 -> （表示） 能進行網路通訊
  - 是否能進行網路通訊？
    - 能連通網路 -> 能找到 NTP server 取得時間
    - 故若能找到 NTP server
    - 則能連通網路。
  - 是否能找到同儕節點？
    - <strike>能連通網路 -> 能找到 NTP server 取得時間</strike>
    - 能連通網路，且網段有同儕節點 -> 能找到同儕節點 
    - 故若能<strike>找到 NTP server，且</strike>找到同儕節點
    - 則能連通網路，且網段有同儕節點

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
