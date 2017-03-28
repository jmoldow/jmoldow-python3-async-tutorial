PYTHON_VIRTUALENV_NAME = .pyvenv
PYTHON_VIRTUALENV_BIN_DIR = ${PYTHON_VIRTUALENV_NAME}/bin
PYTHON_VIRTUALENV_PYTHON_EXE = ${PYTHON_VIRTUALENV_BIN_DIR}/python
PYTHON_VIRTUALENV_PIP_EXE = ${PYTHON_VIRTUALENV_BIN_DIR}/pip
PYTHON_VIRTUALENV_ACTIVATE_EXE = ${PYTHON_VIRTUALENV_BIN_DIR}/activate

PYTHON36_EXE = $(strip $(shell which python3.6))

ifeq (${PYTHON36_EXE},)
  PYTHON36_ERR = $(error python3.6 must be installed and present on the PATH)
endif

.PHONY : all
all : install_requirements

.PHONY : clean
clean :
	git clean -ffdx
	rm -rf ${PYTHON_VIRTUALENV_NAME}

${PYTHON_VIRTUALENV_NAME} :
	$(PYTHON36_ERR)
	virtualenv -p "${PYTHON36_EXE}" ${PYTHON_VIRTUALENV_NAME}

.PHONY : wheel
wheel : ${PYTHON_VIRTUALENV_NAME}
	${PYTHON_VIRTUALENV_PYTHON_EXE} -m pip install -U wheel

.PHONY : setuptools
setuptools : ${PYTHON_VIRTUALENV_NAME} wheel
	${PYTHON_VIRTUALENV_PYTHON_EXE} -m pip install -U setuptools

.PHONY : pip
pip : ${PYTHON_VIRTUALENV_NAME} wheel setuptools
	${PYTHON_VIRTUALENV_PYTHON_EXE} -m pip install -U pip

.PHONY : install_requirements
install_requirements : ${PYTHON_VIRTUALENV_NAME} pip
	${PYTHON_VIRTUALENV_PIP_EXE} install -U -r requirements.txt

.PHONY : run_jupyter_notebook
run_jupyter_notebook : ${PYTHON_VIRTUALENV_NAME} install_requirements
	source ${PYTHON_VIRTUALENV_ACTIVATE_EXE} && ${PYTHON_VIRTUALENV_PYTHON_EXE} -m jupyter notebook
