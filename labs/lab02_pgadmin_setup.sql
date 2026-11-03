-- Lab 02: Initial Connection & Administrative Info
SELECT current_user, current_database(), inet_server_addr(), inet_server_port();
SELECT datname FROM pg_database WHERE datistemplate = false;
