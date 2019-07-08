+++
date = "2019-07-08T14:29:00+07:00"
title = "Cloudflare's terraform provider authentication"
draft = false
categories = ["technical", "terraform", "cloudflare", "devops"]
postsummary = """
This is a guide how to configure authentication for cloudflare's terraform provider.

One of my colleagues mentioned that it's not exactly clear how to do that.

This manual is describing experience with cloudflare's enterprise account, for other types of cloudflare's accounts your mileage may vary.
"""
+++

<!-- more -->
This is a guide how to configure authentication for cloudflare's terraform provider.

One of my colleagues mentioned that it's not exactly clear how to do that.

This manual is describing experience with cloudflare's enterprise account, for other types of cloudflare's accounts your mileage may vary.

# Add cloudflare provider to your terraform state
Just put a file **providers.tf** to your terraform state folder:

```
provider "cloudflare" {
  version = "~> 1.15"
}
```

Version is optional - but I usually add it to avoid unexpected surprises.

# Get your credentials

You will need:

* user's email: your cloudflare user email address
* user's API key
* organization's id

## User's API key

* login to your cloudflare account
* click on your user icon in top right corner of cloudflare user interface
* choose **My Profile**
* Scroll to **API Keys**
* You need **Global API Key**

## Organization's ID
Probably there're easier ways to get cloudflare organization's id. 
But that is what I used.

```
sudo pip install cloudflare
export CF_API_EMAIL="your@email.address"
export CF_API_KEY="your_api_key"
cli4 --get /user
...
    "organizations": [
        {
          "id": "your_organization_id",
...

```

# Cloudflare's terraform provider authentication
Now you have user's email, user's API key and organization id.

Just export those:

```
export CLOUDFLARE_EMAIL="your@email.address"
export CLOUDFLARE_TOKEN="your_api_key"
export CLOUDFLARE_ORG_ID="your_organization_id"
```

I also add those exports to my **~/.bash_profile**.


# Final words
That's all, you can start to configure your cloudflare account with terraform.

```
terraform init # Install all providers
terraform plan # and here terraform will try to connect to cloudflare.
```

# References

* [Terraform docs: Cloudflare Provider](https://www.terraform.io/docs/providers/cloudflare/index.html)
* [Python wrapper for the Cloudflare Client API v4](https://github.com/cloudflare/python-cloudflare)
