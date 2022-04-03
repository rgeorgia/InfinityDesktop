#!/usr/local/bin/python3.7

import platform
import logging
import os

home_dir = os.getenv('HOME')

logging.basicConfig(
     filename=f'{home_dir}/bin/version_history.log',
     format='%(asctime)s %(message)s', 
	 level=logging.DEBUG)

logging.info(platform.version())
print(platform.version())
