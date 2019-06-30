+++
date = "2019-06-30T11:03:00+07:00"
title = "Terraform 0.11 and 0.12 side-by-side"
draft = false
categories = ["technical", "terraform", "devops"]
postsummary = """
This is a guide how to install:

* [terraform](https://www.terraform.io/) 0.11 and 0.12
* [terragrunt](https://github.com/gruntwork-io/terragrunt) 0.18 and 0.19 

side by side on MacOS X.
"""
+++

<!-- more -->
This is a guide how to install:

* [terraform](https://www.terraform.io/) 0.11 and 0.12
* [terragrunt](https://github.com/gruntwork-io/terragrunt) 0.18 and 0.19 

side by side on MacOS X.

# Intro

I use **terraform** and **terragrunt** to automate our AWS IT infrastructure.  

Recently Hashicorp released major **terraform** [upgrade](https://www.hashicorp.com/blog/terraform-0-1-2-preview).  
The main point - upgrade from HCL 1 to HCL 2 (HCL is a language that **terraform** uses to describe IT infra setup.  
There are a lot of useful features in HCL 2 so effort spent on upgrade from **terraform** 0.11 to 0.12 makes sense.  

But to make the upgrade easier - it would be great to have **terraform** 0.11 and 0.12 side by side.  
Then it would be possible to upgrade your **terraform** states one by one - till you upgrade them all!  

Also as we use **terragrunt** we need to have:

* 0.18 version of it compatible with **terraform** 0.11
* 0.19 version of it compatible with **terraform** 0.12

side by side.

# Prerequisites

* [brew](https://brew.sh/) package manager installed.
* I use bash version 5.x, so if there will be any issues with bash scripts - check your bash version.

# Upgrade from **terraform** 0.11 to 0.12 and from **terragrunt** 0.18 to 0.19
Upgrade process from **terraform** 0.11 to **terraform** 0.12 and from **terragrunt** 0.18 to **terragrunt** 0.19 is described on terraform and terragrunt websites:

* [Upgrade from terraform 0.11 to 0.12](https://www.terraform.io/upgrade-guides/0-12.html)
* [Upgrade from terragrunt 0.18 to 0.19](https://github.com/gruntwork-io/terragrunt/blob/master/_docs/migration_guides/upgrading_to_terragrunt_0.19.x.md)

You should just follow instructions to upgrade your **terraform**/**terragrunt** code.

# Install **terraform** 0.11 on MacOS X

```
brew install terraform@0.11
```

# Install **terragrunt** 0.18.x on MacOS X

```
sudo mkdir -p /opt/terragrunt_0.18/bin
cd /opt
chown -R youruser:staff terragrunt_0.18/bin
cd terragrunt_0.18/bin
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.18.7/terragrunt_darwin_amd64
mv terragrunt_darwin_amd64 terragrunt
chmod 755 terragrunt
```

# Install **terraform** 0.12 on MacOS X

```
brew install terraform
```

# Install **terragrunt** 0.19.x on MacOS X

```
brew install terragrunt
```


# Configure switching between **terraform** 0.11/**terragrunt** 0.18 to **terraform** 0.12/**terragrunt** 0.19 and back
Now we need a convenient switching between to sets of **terraform**/**terragrunt**

## Prerequisites

```
mkdir ~/.bash.d
```

Add to **~/.bash_profile**:

```

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # Bash includes
  for include in ~/.bash.d/*.sh ; do source $include ; done
fi

```

Add to **~/.bash.d/init.sh**:

```
append_to_PATH () {
    for d in "$@"; do
        d=$({ cd -- "$d" && { pwd -P || pwd; } } 2>/dev/null)  # canonicalize symbolic links
        if [ -z "$d" ]; then continue; fi  # skip nonexistent directory
        case ":$PATH:" in
            *":$d:"*) :;;
            *) PATH=$PATH:$d;;
        esac
    done
}

prepend_to_PATH () {
    for d in "$@"; do
        d=$({ cd -- "$d" && { pwd -P || pwd; } } 2>/dev/null)  # canonicalize symbolic links
        if [ -z "$d" ]; then continue; fi  # skip nonexistent directory
        case ":$PATH:" in
            *":$d:"*) :;;
            *) PATH=$d:$PATH;;
        esac
    done
}

remove_from_PATH () {
    FOLDERS_TO_REMOVE=`echo "$@" | sed 's/ /|/g'`
    PATH=$( echo ${PATH} | tr -s ":" "\n" | grep -vwE "(${FOLDERS_TO_REMOVE})" | tr -s "\n" ":" | sed "s/:$//" )
}

```

Add to **~/.bash.d/terraform.sh**:

```
# Terraform 0.11&0.12 activation functions
t12 () {
    remove_from_PATH "/usr/local/Cellar/terraform@0.11/0.11.14/bin"
    remove_from_PATH "/opt/terragrunt_0.18/bin"
    export PATH=$PATH
}

t11 () {
    prepend_to_PATH "/usr/local/opt/terraform@0.11/bin"
    prepend_to_PATH "/opt/terragrunt_0.18/bin"
    export PATH=$PATH
}

```

after that:

```
source ~/.bash_profile

t11
terragrunt --version
terragrunt version v0.18.7
terraform --version
Terraform v0.11.14

Your version of Terraform is out of date! The latest version
is 0.12.3. You can update by downloading from www.terraform.io/downloads.html

t12
terragrunt --version
terragrunt version v0.19.6
terraform --version
Terraform v0.12.3
```

Have an easy migration :)
