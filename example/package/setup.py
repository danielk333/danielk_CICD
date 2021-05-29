import setuptools

setuptools.setup(
    name='example',
    version='0.0.1',
    packages=['example'],
    author='Daniel Kastinen',
    description='example-target',
    license='MIT',
    install_requires=[
        'numpy',
    ],
    extras_require={
        "dev":  [
            "pytest",
        ],
    }
)
