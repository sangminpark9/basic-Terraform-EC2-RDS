# AWS Infrastructure with Terraform
이 프로젝트는 Terraform을 사용하여 AWS 상에 웹 애플리케이션 인프라를 구축하는 IaC(Infrastructure as Code) 구현체입니다.

### 인프라 구성도

```
graph TD
    A[AWS Cloud] -->|Contains| B[EC2 Instance]
    A -->|Contains| C[RDS MySQL]
    B -->|Security Group| D[SSH Access]
    B -->|Security Group| E[Default Group]
    C -->|Configuration| F[MySQL 8.0.34]
```

### 주요 구성 요소

##### EC2 Instance
Amazon Linux 2 AMI
t2.micro 인스턴스 타입
SSH 접속 가능


##### RDS Instance
MySQL 8.0.34
db.t3.micro 인스턴스 타입
20GB 스토리지


##### Security Groups
SSH 접속용 보안 그룹 (22번 포트)
기본 보안 그룹

### 전제 조건
Terraform 설치 (1.0.0 이상)
AWS CLI 설정
SSH 키 페어 생성

### 시작하기
1. 환경 변수 설정
```
# variables.tf 파일 생성 후 다음 내용 추가
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  default = "ap-northeast-2"
}
```

2. SSH키 생성
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/web_admin
```

3. Terraform 초기화 및 실행
```
terraform init
terraform plan
terraform apply
```

### 사용법
EC2접속

```
# IP 주소 확인
terraform output instance_ip

# SSH 접속
ssh -i ~/.ssh/web_admin ec2-user@<instance_ip>
```

RDS접속
```
# RDS 엔드포인트 확인
terraform output rds_endpoint

# MySQL 접속
mysql -h <rds_endpoint> -u admin -p
```

### 주의사항
AWS 크레덴셜을 직접 코드에 포함하지 마세요
프로덕션 환경에서는 보안 그룹 규칙을 더 엄격하게 설정하세요
RDS 패스워드는 반드시 변경하여 사용하세요


