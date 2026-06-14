#!/bin/bash

# get admin privileges
sudo su

# install httpd
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
echo "Welcome to 121Training" > /var/www/html/index.html



# Exit immediately if a command exits with a non-zero status
set -e

# --- CONFIGURATION ---
# Replace these values with your target username and their actual public SSH key string
NEW_USER="myajay"
SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCk/luAy8BopgblGkkTitHEXO36QxRn16x7vNp4dtf4X+JTK6wZiblDp/I8tt53hq13Ty9jSA4381dzNOvU7n08Bzq2VxnyG8rScHskA01Nk2Q0bKisaJtpAxNKewDgNf1w1h5JnIicjAXkws3ZUTMNlxaHq8F4hGRD4KGWIh7k6ZLlUQX6PK0evHYEbTI7trBBjhyGkalqqFv/kzf7ZA0XdzpbyHP0DyjhDO9FApzI5Y0MfYyqR6xfO/xn4sH0iCjxXH0JeDuSQdn94vKwYou8gCaLdUHlr+ecvXGs4i7PP5lF6WUhFMGepAEoFLqWtjA+Z0t1iWma0+/DYA23uAK+fb1rFyz6Qh88oHAxgNt7ZpQELWhjjkirRun5lYR+Sulr7VdjNhAhrj70RpVCSXg1vDeV/2onJHuiepBGaeE0sTHXckvESOipK0veQSWPFQ+Mz3QqmHEGAg4hE51xFtE7FXwEhUbeTBY8VLWHddgWzb2H3uIZtAuXG8PEvIiGOMs= nahee@Mac.phub.net.cable.rogers.com"
# ---------------------

# Ensure the script is run with root/sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "❌ Error: Please run this script with sudo or as root." >&2
  exit 1
fi

echo "👤 Creating new user: ${NEW_USER}..."

# Check if user already exists to avoid errors
if id "$NEW_USER" &>/dev/null; then
  echo "⚠️ User '${NEW_USER}' already exists. Skipping user creation."
else
  # Create user with a home directory and default bash shell
  useradd -m -s /bin/bash "$NEW_USER"
  echo "✅ User '${NEW_USER}' created successfully."
fi

# Set up the .ssh directory structure
USER_HOME="/home/${NEW_USER}"
SSH_DIR="${USER_HOME}/.ssh"
AUTH_KEYS="${SSH_DIR}/authorized_keys"

echo "🔑 Configuring SSH directory and adding public key..."
mkdir -p "$SSH_DIR"

# Write the public key to the authorized_keys file safely
echo "$SSH_PUBLIC_KEY" > "$AUTH_KEYS"

# Enforce mandatory strict SSH directory and file permissions
chmod 700 "$SSH_DIR"
chmod 600 "$AUTH_KEYS"

# Transfer folder ownership from root to the new user
chown -R "${NEW_USER}:${NEW_USER}" "$SSH_DIR"
echo "✅ SSH directory permissions configured."

# Optional: Grant sudo access without password prompt
echo "⚙️ Configuring sudo access..."
SUDOERS_FILE="/etc/sudoers.d/${NEW_USER}"

echo "${NEW_USER} ALL=(ALL) NOPASSWD:ALL" > "$SUDOERS_FILE"
chmod 0440 "$SUDOERS_FILE"
echo "✅ Sudo privileges granted."

echo "🎉 Setup complete! The user '${NEW_USER}' can now connect via SSH."
