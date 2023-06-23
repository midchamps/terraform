# main.tf 구조

## data block

- 주어진 aws_availbility zone 을 az로 export 하는 역할
- 같은 파일 내 다른 모듈에서 az를 사용할 수 있음

## module block

- terraform registry에서 vpc module을 가져와서 사용
- 각각 필요한 argument들은 모두 registry 문서에 작성되어있음
- AZ 는 서울 리전에서 사용할 수 있는 모든 존을 사용
- 각각 AZ존에 할당해야하는 subnet 주소도 3개씩 할당
- NAT gateway는 현재 single natgateway로 설정되어있음. Nat gateway의 가용영역이 다운 될 경우, 다른 영역의 리소스도 인터넷에 접근할 수 없게됨.
