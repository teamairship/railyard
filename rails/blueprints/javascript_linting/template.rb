def apply_self!
  if yes?("Would you like to run ESLint with overcommit?")
    content = "  EsLint:\n    enabled: true\n    on_warn: pass\n    required_executable: './node_modules/.bin/eslint'\n    command: ['./node_modules/.bin/eslint']\n\n"
    insert_into_file '.overcommit.yml', content, before: /PostCheckout:\n/
  end

  if yes?("Would you like to install Prettier?")
    run "npm install --save-dev eslint-config-prettier eslint-plugin-prettier"
    insert_into_file '.eslintrc.js', "    'prettier',\n", after: /    'airbnb-base',\n/
    insert_into_file '.eslintrc.js', "    'prettier/prettier': ['error'],\n", after: /  rules: {\n/
    gsub_file '.eslintrc.js', /  plugins: .+/, "  plugins: [\n    'prettier',\n  ],"
  end
end

apply_self!
