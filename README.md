# STGR_henshin
変身します。

## 動作環境
- FiveM

## インストール方法
1. `stgr_henshin`をリソースフォルダに追加します。
2. `server.cfg`に`ensure stgr_henshin`を追加します。

## 使い方
- `/henshin cat`: 猫に変身します。
- `/henshin dog`: 犬に変身します。
- `/henshin`: 元に戻ります。

## 仕様

### 【クライアント側】

1. client.luaファイルにRegisterCommand関数を使用して、コマンドを登録する。
2. コマンド実行時に、TriggerServerEvent関数を使用して、サーバー側に変身をリクエストする。
3. サーバー側からレスポンスが返ってきた場合に、TriggerEvent関数を使用して、プレイヤーのモデルを変更する。

### 【サーバー側】

1. server.luaファイルに、RegisterServerEvent関数を使用して、クライアント側からのリクエストを受け取るイベントを登録する。
2. イベントハンドラー内で、setPlayerModel関数を使用してプレイヤーのモデルを変更する。
3. クライアント側にレスポンスを返す場合は、TriggerClientEvent関数を使用する。

また、以下の変更点が必要です。
1. サーバー側で、変身可能なモデルに制限を設ける。
2. クライアント側で、変身前のモデルIDを保存しておき、変身後に戻すために使用する。