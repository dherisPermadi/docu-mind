# README - DocuMind (Content Reader)
A Simple Content Reader that can answer all of your questions based on the content that you've uploaded.

# Requirement
  - PostgreSQL
  - Rails v. 7.0.8
  - Ruby v. 3.2.1

# Install Gem / Libraries
  - run ```bundle install```

# Set the ENV Variable
  - Create ```.env``` file in the root
  - Set value to variables ```POSTGRES_USER and POSTGRES_PASSWORD```

# Database Build
  - run ```rake db:create```
  - run ```rake db:migrate```
  - run ```rake db:seed```

# Run Unit Test
  - run ```bundle exec rspec```

# Run Server on Local / Development Environment
  - make sure you are in the root of the folder project / repository
  - run ```rails s```
  - then you can open the web on the localhost url. example: http://localhost:8000
