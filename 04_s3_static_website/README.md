Objective: Deploy an S3 bucket that will host the files for the static website
1. Create S3 bucket 
2. Disable public access block so that others can access the bucket via the internet
3. create policy that allows the `s3:GetObject` action for anyone and for all objects within the created bucket
4. Create a S3 static website configuration and link to existing bucket
5. Create output with the S3 Static Website endpoint