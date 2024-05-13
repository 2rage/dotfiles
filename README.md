# Dotfiles

## Linux/Darwin installation

```bash
cd ~ && git clone git@github.com:2rage/dotfiles.git && cd dotfiles && source bootstrap.sh
```
## Windows installation

```bash
cd ~ && git clone git@github.com:2rage/dotfiles && cd dotfiles && git checkout windows && .\bootstrap.ps1
```

## ToDo

- [ ] Create script for a first system init. The following apps and dependencies need to be installed:
  - [ ] **zsh**
  - [ ] **brew**
  - [ ] **starship**
  - [ ] **python3**
  - [ ] **poetry**
  - [ ] **rsync**
  - [ ] **git**
  - [ ] **net-tools**
  - [ ] **tree**
  - [ ] **htop**
  - [ ] **neofetch**
  

### 1. Установка ZSH в Linux

1. Чтобы установить zsh в Debian 11, запустите:
  ```$ sudo apt install zsh```
2. Чтобы проверить установку zsh:
  ``` $ which zsh ```
  ``` /usr/bin/zsh ```
Из выходных данных видно, что zsh успешно установлен в /usr/bin/zsh.

3. Изменить текущую оболочку
Сначала проверьте, в какой оболочке вы сейчас работаете, с помощью следующей команды echo:
  ``` echo $SHELL ```
  ``` /bin/bash ```
Приведенный выше вывод показывает, что в настоящее время используется оболочка bash.
Чтобы изменить оболочку по умолчанию, вы должны выполнить следующую команду chsh:

    ``` $ chsh -s $(which zsh) ```

Выйдите из текущего сеанса, теперь, когда вы войдете заново в терминал, у вас будет оболочка Zsh вместо bash по умолчанию.


### 2. Установка homebrew

Перед установкой Homebrew убедитесь, что у вас установлены все необходимые зависимости. Откройте терминал и выполните следующую команду:

```bash
sudo apt install build-essential curl file git -Y
```

Эта команда установит компиляторы, утилиты для сборки, Git и другие инструменты, необходимые для работы Homebrew

Если Homebrew не был автоматически добавлен в ваш PATH, добавьте следующие строки в файл ~/.zshrc:

```bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

Затем перезагрузите ваш терминал или активируйте изменения командой:

```bash
source ~/.zshrc
```


### 3. Установка последней версии starship

1. ```brew install starship ```
