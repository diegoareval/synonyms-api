admin = Admin.find_by(username: 'admin')

if admin.nil?
    Admin.create(
        username: 'admin',
        password: '$2a$12$K5wKU26sExGYP/BW/YXXj.mSmVCl32IaKuE.HsdjaKSWrWsUJ2v8K' # Password: $dm!nhola123
    )
else
    puts 'Admin already exists. No action taken.'
end