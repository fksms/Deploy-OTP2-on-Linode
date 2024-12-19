## 利用方法

### はじめに

[こちら](https://cloud.linode.com/profile/tokens)からAccess Tokenの取得を行う。<br>

とりあえず、`Events`、`Firewalls`、`Linodes`、`StackScripts`を`Read/Write`に設定し、それ以外は`No Access`でOK。<br>
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

確認
```sh
terraform plan
```

起動
```sh
terraform apply
```

削除
```sh
terraform destroy
```