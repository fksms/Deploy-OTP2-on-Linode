## 利用方法

### 0. はじめに

[こちら](https://cloud.linode.com/profile/tokens)からAccess Tokenの取得を行う。<br>
各リソースへのアクセス権限については、`Events`、`Firewalls`、`Linodes`、`StackScripts`を`Read/Write`に設定し、それ以外は`No Access`に設定する。<br>

また、OpenTripPlannerで利用するグラフはビルドに時間を要するため、あらかじめローカルでビルドを行い、ビルド済みのグラフをGoogle Driveに格納しておく。<br>
ビルド方法は[こちら](https://github.com/fksms/Deploy-OTP2-on-Docker)を参考。<br>
Google Drive格納後、共有設定で`リンクを知っている全員`に設定し、リンクの発行を行い、`download_assets.sh`の`fileId`に書き込んでください。<br>
<br>

### 1. 環境構築

Terraformのインストール
```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```
<br>

### 2. デプロイ

tfvarsファイルのコピー （取得したAccess Tokenを`terraform.tfvars`に書き込んでください）
```sh
cp terraform.tfvars.example terraform.tfvars
```

ワークスペースの初期化
```sh
terraform init
```

構成が有効かを確認
```sh
terraform validate
```

現在の構成に必要な変更を表示
```sh
terraform plan
```

インフラストラクチャの作成または更新（起動）
```sh
terraform apply
```

インフラストラクチャの破棄（終了）
```sh
terraform destroy
```
<br>

### 3. APIの動作確認

https://docs.opentripplanner.org/en/dev-2.x/sandbox/TravelTime/

上記を参考<br>
このAPIはVer2.6で無効になり、上記リンクも削除されてしまう可能性があるため、APIのパラメータを以下に示す。<br>

#### API parameters

- `location` Origin of the search, can be either `latitude,longitude` or a stop id
- `time` Departure time as a ISO-8601 time and date (example `2023-04-24T15:40:12+02:00`). The default value is the current time.
- `cutoff` The maximum travel duration as a ISO-8601 duration. The `PT` can be dropped to simplify the value. This parameter can be given multiple times to include multiple isochrones in a single request. The default value is one hour.
- `modes` A list of travel modes. WALK is not implemented, use `WALK, TRANSIT` instead.
- `arriveBy` Set to `false` when searching from the location and `true` when searching to the location

#### Example Request

IPアドレスは[こちら](https://cloud.linode.com/linodes)で確認できる。
```
http://xxx.xxx.xxx.xxx:8080/otp/traveltime/isochrone?batch=true&location=35.63273135483024,139.74189548323065&time=2024-12-03T14:00:00%2B09:00&modes=WALK,TRANSIT&arriveBy=true&cutoff=30M&cutoff=60M
```
