## 利用方法

### はじめに

[こちら](https://cloud.linode.com/profile/tokens)からAccess Tokenの取得を行う。<br>
各リソースへのアクセス権限については、`Events`、`Firewalls`、`Linodes`、`StackScripts`を`Read/Write`に設定し、それ以外は`No Access`に設定する。<br>

また、OpenTripPlannerで利用するグラフはビルドに時間を要するため、あらかじめローカルでビルドを行い、ビルド済みのグラフをGoogle Driveに格納しておく。<br>
ビルド方法は[こちら](https://github.com/fksms/Deploy-OTP2-on-Docker)を参考。<br>
Google Drive格納後、共有設定で`リンクを知っている全員`に設定し、リンクの発行を行い、`download_assets.sh`の`fileId`に書き込んでください。<br>
<br>

### 環境構築

Terraformのインストール
```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```
<br>

### デプロイ

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
