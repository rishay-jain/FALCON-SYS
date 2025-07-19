from setuptools import setup

package_name = 'simple_talker'

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='falcon',
    maintainer_email='your_email@example.com',
    description='Simple talker example',
    license='Apache License 2.0',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'talker = simple_talker.simple_talker:main',
        ],
    },
)
