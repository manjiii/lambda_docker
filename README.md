
# Set up
1. Clone this repository.
2. Run poetry install.
  
```sh
poetry install
```

# Run lambda in local
- Run lambda using python for test
  
```sh
source  .venv/bin/activate
python lambda_function.py
```
or

- In VSCode, press [F5](to run debug)
  
  *This repository contains launch.json



# Run lambda in docker container
- Run lambda using python for test

```sh
sh commands/lambda_run.sh
```

# Package and Make zip file
1. Make zip file

```sh
sh commands/lambda_buiild.sh
```

2. Upload "deploy_package.zip" to lambda.

