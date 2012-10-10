web: bundle exec rails server thin -p $PORT -e production
worker: bundle exec thin -p $PORT -e production -R private_pub.ru start
