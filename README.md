# AWSインフラ設計・構築

AWSで利用される代表的なアーキテクチャを題材に、
AWSインフラの設計・構築およびTerraformによるInfrastructure as Code（IaC）を学習・検証するリポジトリです。  
AWSサービスを個別に学習するだけではなく、
アーキテクチャ全体の構成や各サービスの役割、サービス間の連携、設計意図を理解したうえで、
AWSコンソールによる構築・検証からTerraformによるIaC化、  
Ansibleによる構成管理やCI/CDによるデプロイ自動化まで実践しています。

---

# 学習・検証方針

各アーキテクチャについて、以下の流れを基本として学習・検証しています。

1. アーキテクチャの設計
2. AWSコンソールによる構築
3. 動作確認・検証
4. 構築手順の整理
5. TerraformによるIaC化
6. `terraform plan` / `terraform apply` / `terraform destroy` による再現性の確認
7. Terraformで再構築した環境での動作確認
8. GitHubによるソースコード・ドキュメント管理

構成に応じて、AnsibleによるOS・ミドルウェア設定や、
AWSサービスを利用したデプロイ自動化についても検証しています。

---

# プロジェクト一覧

| 状態 | パターン | 内容 |
| --- | --- | --- |
| Completed | Pattern 1 | 高可用Webアーキテクチャ |
| Completed | Pattern 2 | イベント駆動アーキテクチャ |
| Completed | Pattern 3 | CI/CDパイプライン |
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

GitHubで管理されたFastAPIアプリケーションを対象として、
自動テストからAmazon EC2へのデプロイまでを行うCI/CDパイプラインを設計・構築しています。  
AWS CodePipelineを中心に、CodeBuildによる自動テストとCodeDeployによるEC2へのデプロイを連携し、
**テストに成功したコードのみをデプロイする仕組み**を構築しています。  
また、AWSリソースをTerraformでコード化し、
EC2の初期構築をAnsibleで自動化することで、
インフラ構築・サーバ構成管理・アプリケーションデプロイの役割を分離しています。

### 主な構成

- AWS CodePipeline
- AWS CodeBuild
- AWS CodeDeploy
- AWS CodeConnections
- Amazon S3
- Amazon EC2
- AWS IAM
- Amazon CloudWatch Logs
- Python
- FastAPI
- pytest
- Ansible
- Terraform
- GitHub

詳細は `ci-cd/README.md` を参照してください。

---

## Pattern 4 - コンテナアーキテクチャ

コンテナを利用したアーキテクチャを設計・構築します。

---

# 目的

AWSサービスの個別機能や操作方法を学習するだけではなく、
代表的なアーキテクチャを題材として設計・構築・検証・IaC化までを一貫して経験することで、
AWSインフラに関する設計・構築スキルを実践的に身につけることを目的としています。  
また、インフラ構築だけでなく、
構成管理・テスト・デプロイなど周辺工程の自動化についても実際に構築・検証することで、
AWS上でシステムを継続的に運用・改善するための仕組みについて理解を深めています。