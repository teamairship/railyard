def apply_self!
    if yes?("Would you like to install GraphQL?", :blue)
        gem "graphql"
        gem 'graphiql-rails', git: 'https://github.com/rmosolgo/graphiql-rails', branch: 'master'
        run "bundle install"
        generate "graphql:install"
    end
end

apply_self!
