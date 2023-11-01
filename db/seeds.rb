admin = Admin.find_by(username: 'admin')

if admin.nil?
    Admin.create(
        username: 'admin',
        password: '$dm!nhola123' # Password: $dm!nhola123
    )
else
    puts 'Admin already exists. No action taken.'
end