# Troubleshooting at the CBU

## You see `pyenv: Command not found`, `poetry: Command not found`

On the CBU nodes, `pyenv` only works in `bash`, so make sure you are using this.
```
bash
```

## You see `/lib64/libm.so.6: version 'GLIBC_2.29' not found` when running gridsearch

You are running it on a cbu node that does not have the right libraries installed. You could try it on a node which does (such as `lws-gpu02`), or (prefered) use `submit_gridsearch.sh` which will implement apptainer which layers the right libraries over the top of the node. 

## You see `ModuleNotFoundError: No module named 'numpy'`

You are probably running `submit_gridsearch.sh`, and it currently has Andy's toolbox location hard-coded.
Update to point it at your copy.

## You see `ModuleNotFoundError: No module named 'kymata'`

You're not using the poetry environment.  You'll need to run this with Apptainer.

First make sure the toolbox is installed with `poetry`, so the `kyamata` package is available within the virtual environment:

```shell
apptainer shell -B /imaging/projects/cbu/kymata /imaging/local/software/singularity_images/python/python_3.11.7-slim.sif
export VENV_PATH=~/poetry/
cd /path/to/kymata-toolbox
$VENV_PATH/bin/poetry install
```
Now (within the Apptainer) you can run it using `poetry`, e.g.:
```shell
$VENV_PATH/bin/poetry run python invokers/invoker_create_trialwise_data.py
```