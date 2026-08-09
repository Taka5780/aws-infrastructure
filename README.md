# AWSインフラ設計・構築

AWSインフラ設計・構築およびTerraformによるInfrastructure as Code（IaC）の学習・検証リポジトリです。  
AWSコンソールで設計・構築・動作確認した環境をTerraformでコード化し、設計から構築・検証まで一貫して実施しています。  
Terraformの文法を学ぶことだけではなく、AWSサービスの役割や設計意図を理解し、Infrastructure as Code（IaC）として再現できることを目的としています。  
本リポジトリでは、AWSで利用される代表的なアーキテクチャを題材に、設計・構築・IaCまでを一貫して学習・実装していきます。  

---

# 学習方針

本リポジトリでは、以下の流れで学習を進めています。

1. AWSコンソールで設計・構築
2. 動作確認
3. 構築手順の整理
4. TerraformによるIaC化
5. `terraform plan` / `terraform apply` / `terraform destroy` による検証
6. GitHubによるソースコード管理

---

# プロジェクト一覧

| 状態 | パターン | 内容 |
|------|----------|------|
| Completed | Pattern 1 | 高可用Webアーキテクチャ |
| In Progress | Pattern 2 | イベント駆動アーキテクチャ |
| Planned | Pattern 3 | CI/CDパイプライン |
| Planned | Pattern 4 | サーバーレスアーキテクチャ |
| Planned | Pattern 5 | コンテナアーキテクチャ |
| Planned | Pattern 6 | 静的サイト配信アーキテクチャ |

---

# プロジェクト

## Pattern 1 - 高可用Webアーキテクチャ

AWS上に高可用なWebアーキテクチャを構築し、AWSコンソールで設計・構築した構成をTerraformでコード化しています。

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

AWSイベントを契機とした自動処理アーキテクチャを構築します。

### 学習予定サービス

- Amazon EventBridge
- AWS Lambda
- Amazon SNS
- Amazon SQS
- Amazon CloudWatch

---

## Pattern 3 - CI/CDパイプライン

ソースコード管理からデプロイまでの自動化基盤を構築します。

### 学習予定サービス

- GitHub Actions
- AWS CodePipeline
- AWS CodeBuild
- AWS CodeDeploy

---

## Pattern 4 - サーバーレスアーキテクチャ

サーバーレスアーキテクチャを構築します。

### 学習予定サービス

- Amazon API Gateway
- AWS Lambda
- Amazon DynamoDB

---

## Pattern 5 - コンテナアーキテクチャ

コンテナを利用したアプリケーション実行アーキテクチャを構築します。

### 学習予定サービス

- Amazon ECS
- Amazon ECR
- Application Load Balancer
- Auto Scaling

---

## Pattern 6 - 静的サイト配信アーキテクチャ

静的Webサイト配信アーキテクチャを構築します。

### 学習予定サービス

- Amazon S3
- Amazon CloudFront
- Amazon Route 53
- AWS Certificate Manager（ACM）

---

# 目的

AWSサービスを個別に学習するだけではなく、実際の運用で利用されるアーキテクチャを題材に、設計・構築・Infrastructure as Codeを通して実践的なAWSインフラ設計スキルを習得することを目的としています。