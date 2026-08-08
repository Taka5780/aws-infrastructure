# AWS Infrastructure

AWSインフラ設計・構築およびTerraformによるInfrastructure as Code（IaC）の学習・検証リポジトリです。  
AWSコンソールで設計・構築・動作確認した環境をTerraformでコード化し、設計から構築・検証まで一貫して実施しています。  
Terraformの文法を学ぶことだけではなく、AWSサービスの役割や設計意図を理解し、実際のシステム構成を再現できることを目的としています。  

---

# 学習方針

本リポジトリでは、以下の流れで学習を進めています。

1. AWSコンソールで設計・構築
2. 動作確認
3. 構築手順の整理
4. TerraformによるIaC化
5. terraform plan / apply / destroy による検証
6. GitHubによるソースコード管理

---

# プロジェクト一覧

| 状態 | プロジェクト | 内容 |
|------|-------------|------|
| Completed | Pattern 1 | 高可用Webアプリケーション |
| In Progress | Pattern 2 | イベント駆動アーキテクチャ |
| Planned | Pattern 3 | CI/CDパイプライン |
| Planned | Pattern 4 | サーバーレスAPI |
| Planned | Pattern 5 | コンテナ基盤 |
| Planned | Pattern 6 | 静的サイト配信 |

---

# 各プロジェクト

## Pattern 1 - 高可用Webアプリケーション

Terraformを利用して高可用なWebアプリケーション基盤を構築します。

### 主な構成

- Amazon VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Route Table
- Security Group
- Application Load Balancer
- Target Group
- Launch Template
- Auto Scaling Group
- Amazon RDS

詳細は high-availability/README.md を参照してください。

---

## Pattern 2 - イベント駆動アーキテクチャ

AWSイベントを利用した自動処理基盤を構築します。

### 主なサービス

- Amazon EventBridge
- AWS Lambda
- Amazon SNS
- Amazon SQS
- Amazon CloudWatch

---

## Pattern 3 - CI/CDパイプライン

ソースコード変更からデプロイまでの自動化基盤を構築します。

### 主なサービス

- GitHub Actions
- AWS CodePipeline
- AWS CodeBuild
- AWS CodeDeploy

---

## Pattern 4 - サーバーレスAPI

サーバーレスアーキテクチャによるAPIを構築します。

### 主なサービス

- Amazon API Gateway
- AWS Lambda
- Amazon DynamoDB

---

## Pattern 5 - コンテナ基盤

コンテナ実行基盤を構築します。

### 主なサービス

- Amazon ECS
- Amazon ECR
- Application Load Balancer

---

## Pattern 6 - 静的サイト配信

静的Webサイト配信基盤を構築します。

### 主なサービス

- Amazon S3
- Amazon CloudFront
- Amazon Route 53

---

# 今後の予定

各プロジェクトについて、以下の内容を順次追加します。

- アーキテクチャ図
- Terraformコード
- 設計方針
- 構築手順
- 動作確認結果

---

# 目的

AWSサービスを個別に学習するだけではなく、実際の運用で利用される構成を題材に、  
設計・構築・Infrastructure as Codeを通して実践的なAWSインフラ設計スキルを習得することを目的としています。