ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :superadmin

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :superadmin
    actions
  end

  filter :email
  filter :superadmin

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :superadmin, label: "Super Administrator"
    end
    f.actions
  end

end
