from setuptools import setup, find_packages

setup(
    name='vscode-python-test',
    version='0.1.0',
    packages=find_packages(exclude=['tests']),
    install_requires=['click'],
    entry_points="""
        [console_scripts]
        myscript=resize_cn:cli
    """
)