<?php

return array(
    'auth' => array(
    ),
    'storage' => function() {
	return new Imbo\Storage\Filesystem(array(
            'dataDir' => '/path/to/images',
        ));
    },
    'database' => function() {
        return new Imbo\Database\Doctrine(array(
            'dbname'   => '',
            'user'     => '',
            'password' => '',
            'host'     => '',
            'driver'   => 'pdo_mysql',
        ));
    },
);
