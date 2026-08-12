# AWSインフラ設計・構築

AWSで利用される代表的なアーキテクチャを題材に、
AWSインフラの設計・構築およびTerraformによるInfrastructure as Code（IaC）を学習・検証するリポジトリです。  
AWSサービスを個別に学習するだけではなく、
アーキテクチャ全体の構成や各サービスの役割、サービス間の連携、設計意図を理解したうえで、
AWSコンソールによる構築からTerraformによる再現まで一貫して実施しています。

---

# 学習・検証方針

各アーキテクチャについて、以下の流れで学習・検証しています。

1. アーキテクチャの設計
2. AWSコンソールによる構築
3. 動作確認・検証
4. 構築手順の整理
5. TerraformによるIaC化
6. `terraform plan` / `terraform apply` / `terraform destroy` による再現性の確認
7. Terraformで再構築した環境での動作確認
8. GitHubによるソースコード・ドキュメント管理

---

# プロジェクト一覧

| 状態 | パターン | 内容 |
| --- | --- | --- |
| Completed | Pattern 1 | 高可用Webアーキテクチャ |
| Completed | Pattern 2 | イベント駆動アーキテクチャ |
| Planned | Pattern 3 | CI/CDパイプライン |
| Planned | Pattern 4 | コンテナアーキテクチャ |

---

# プロジェクト

## Pattern 1 - 高可用Webアーキテクチャ

AWS上に高可用なWebアーキテクチャを設計・構築し、
AWSコンソールで構築・検証した構成をTerraformでコード化しています。

### 主な構成

- Amazon VPC
- Public / Private Subnet
- Internet Gateway
- Route Table
- Security Group
- Application Load Balancer
- Target Group
- Launch Template
- Auto Scaling Group
- Amazon EC2
- Amazon RDS
- Terraform

詳細は `high-availability/README.md` を参照してください。

---

## Pattern 2 - イベント駆動アーキテクチャ

Amazon S3への画像アップロードを契機として、
画像の検証・リサイズ・保存・通知を自動実行するイベント駆動アーキテクチャを設計・構築しています。  
AWSコンソールで構築・動作確認した構成をTerraformでコード化し、
Terraformによる再構築後も正常系・異常系を含めた動作確認を実施しています。

### 主な構成

- Amazon S3
- Amazon EventBridge
- AWS Lambda
- Amazon SNS
- AWS IAM
- Amazon CloudWatch Logs
- Python
- boto3
- Pillow
- Terraform

詳細は `event-driven/README.md` を参照してください。

---

## Pattern 3 - CI/CDパイプライン

CI/CDパイプラインを題材としたアーキテクチャを設計・構築します。

---

## Pattern 4 - コンテナアーキテクチャ

コンテナを利用したアーキテクチャを設計・構築します。

---

# 目的

AWSサービスの個別機能や操作方法を学習するだけではなく、
代表的なアーキテクチャを題材として設計・構築・検証・IaC化までを一貫して経験することで、
AWSインフラに関する設計・構築スキルを実践的に身につけることを目的としています。