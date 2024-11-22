# DevOps Engineer - Technical Test

## Tools and Technologies

This project is fully cloud-native, utilizing AWS. The tools and technologies used are:

- **CI Service:** Jenkins
- **Provisioning Tool:** CloudFormation
- **Local Environment:** Docker
- **Load Balancer:** Application Load Balancer
- **Version Control:** Git

> **Note:** The Jenkins application is accessible to anyone to facilitate the double-check process of this challenge.

## Solution Process

### 1. Run and Test the App Server Locally

During this process, I ensured that the Node.js app could run locally. The following steps were taken:

- Verified that Docker was installed.
- Created a `Dockerfile` and pushed it to the hub registry for local testing.
- Modified `test/app.test.js` to follow CommonJS conventions, adding the `type` key inside `package.json` with `module` as its value.
- Ensured that `index.js` reads the target file dynamically.
- Created a `Dockerfile` to package the Node server app on **port 3000**.
- Built the Docker image and confirmed it was running locally on **port 3000**.
> **Note:** Optionally pushed to Docker Hub as a backup, which can be found [hub.docker.com/r/nurwandi7/ntx-devops-test/tags](https://hub.docker.com/r/nurwandi7/ntx-devops-test/tags).

### 2. Provision Using CloudFormation

The CloudFormation template is located in `AWS/cloudFormation.yaml`. During this step, I created the following resources:

- VPC
- Public Subnet 1
- Public Subnet 2
- Internet Gateway
- Security Group
- Two instances to serve as Jenkins agents
- Load Balancer
- Target Group for the Load Balancer
- Listener for the Load Balancer

After creating these resources, I provisioned them directly on AWS by creating a stack.

![.](https://hadith-of-the-day-replication-9162024.s3.us-east-1.amazonaws.com/gif/Screenshot+2024-11-23+040000.png)

Goals:
- ✅ The infrastructure is fully automated and deployable using IaC and CI/CD pipelines

### 3. Double Check Two EC2 Instances

In this step, I ensured that the Security Group allowed port 22 for SSH access. I also checked the Docker installation inside the EC2 instances by running:
```
sudo service docker start
sudo usermod -aG docker ec2-user
docker --version
docker run -d -p 3000:3000 nurwandi7/ntx-devops-test:obi.11.21.2024
```

Both instances needed Java installed, which I addressed by running:

```
sudo yum install -y java-17-amazon-corretto
```

Additionally, I used a Jenkins agent to connect to Jenkins, as the SSH connector has limitations. I ensured the Jenkins agent runs in the background using the `nohup` command, so it remains active even when the EC2 instance is closed from SSH or Session Manager.

I initiated to create an AMI in order to back up my instance.

![.](https://hadith-of-the-day-replication-9162024.s3.us-east-1.amazonaws.com/gif/Screenshot+2024-11-22+181534.png)

### 4. Double Check Listener

While provisioning the **Load Balancer**, I ensured that the listener targeted the target group of instances. The Load Balancer should return the hostname dynamically when accessed.

![.](https://hadith-of-the-day-replication-9162024.s3.us-east-1.amazonaws.com/gif/Screenshot+2024-11-22+060444.png)

Lastly, I made sure that we implement the round robin.

![.](https://hadith-of-the-day-replication-9162024.s3.us-east-1.amazonaws.com/gif/Screenshot+2024-11-22+060136.png)

Goals:
- ✅ Accessible via HTTP on port 80.  
- ✅ Configured to use a round-robin strategy to distribute traffic between application servers.

### 5. Provision Jenkins

I provisioned Jenkins manually without Infrastructure as Code (CloudFormation) to avoid misconfiguration during this challenge. I ensured that Jenkins could receive traffic on **port 8080** in the Security Group.

<img src="https://hadith-of-the-day-replication-9162024.s3.us-east-1.amazonaws.com/gif/Screenshot+2024-11-22+063433.png" alt="." style="margin-bottom: 20px;" />
<img src="https://hadith-of-the-day-replication-9162024.s3.us-east-1.amazonaws.com/gif/Screenshot+2024-11-22+074408.png" alt="." />

Once Jenkins was running, I installed essential plugins such as **Git**, **EC2**, and **Cloud**. I added SSH credentials for GitHub to facilitate project cloning, attaching the **IAM access key** to the Jenkins credentials. I also ensured that both agents from the two EC2 instances were running.

### 6. Creating Modular Scripts

I created several scripts inside the `Jenkins/` folder that Jenkins would run and execute:

- `00.clone_repository.sh`: Contains the command to clone the repository (optional, as I used the project directly from the workspace).
- `01.testing_local_app.sh`: Installs Node.js and tests the local app running on port 3000.
- `02.docker_installation.sh`: Builds the Docker image and ensures the Docker daemon is activated.
- `03.docker_run.sh`: Checks the Docker version and runs the Docker image built from the previous script.

In the same folder, I also created a `Jenkinsfile`. For execution, I implemented parallel execution targeting the two Jenkins agents from our two instances. I ran the pipeline multiple times to adjust the scripts, especially regarding path directories. I modified the bash scripts to include soft checks to verify if the server and Docker were already installed. Additionally, I added the command:

```
sh 'chmod +x Jenkins/*'
```

to ensure we had permission to run all scripts in the pipeline.

Goals:
- ✅ Modular scripts

### 7. Fault Tolerance on Jenkins Master

to-do:
- implement ASG on jenkins master instance

consideration:
- cost effective, for small workload
- only running one instance

### 8. Web-hook

to-do

### 9. Finalization

Lastly, I added a post-success block to inform the user that the app is now running on the Load Balancer: [ntx-devops-test-alb-1605014626.us-east-2.elb.amazonaws.com/](http://ntx-devops-test-alb-1605014626.us-east-2.elb.amazonaws.com/)


![.](https://hadith-of-the-day-replication-9162024.s3.us-east-1.amazonaws.com/gif/Screenshot+2024-11-22+225920.png)

Goals:
- ✅ The CI pipeline should deploy the application to the target environment after a successful build.

## Final Result

![.](https://hadith-of-the-day-replication-9162024.s3.us-east-1.amazonaws.com/gif/ntx-01.gif)

Goals:
- ✅ Two instances running this web application, using two servers
- ✅ Each accessible via HTTP on port 3000.
- ✅ The application must respond with:
`Hi there! I'm being served from {hostname}!`
---
- The Jenkins pipeline can be found at: [18.222.136.115:8080/job/ntx-devops-test-ci/](http://18.222.136.115:8080/job/ntx-devops-test-ci/)
- Load Balancer: [ntx-devops-test-alb-1605014626.us-east-2.elb.amazonaws.com/](http://ntx-devops-test-alb-1605014626.us-east-2.elb.amazonaws.com/)
- EC2 Instance Node-Server-1: [18.218.170.152:3000/](http://18.218.170.152:3000/)
- EC2 Instance Node-Server-2: [3.141.36.115:3000/](http://3.141.36.115:3000/)
