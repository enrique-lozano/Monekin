# Commit message convention for Monekin

To ensure a correct reading of commits and to facilitate their subsequent search or enable automation processes for the app, we use well-defined criteria when formulating commit messages. This criterion is based on the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), and is explained below:

In general, the same pattern is followed as explained in the documentation of this convention, which is:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

The only condition we add here is that the description (also called subject) must start with an **uppercase** letter.

In addition, in order to simplify the process we have reduced the number of possible types, which are the same as Angular follows in its [convention](https://github.com/angular/angular/blob/main/CONTRIBUTING.md#type):

- **build**: Changes that affect the build system or external dependencies. Upgrade and remove dependencies, packages...
- **ci**: Changes to our CI configuration files and scripts
- **docs**: Documentation only changes
- **feat**: A new feature
- **fix**: A bug fix
- **perf**: A code change that improves performance
- **refactor**: A code change that neither fixes a bug nor adds a feature, move or rename files/resources...
- **test**: Adding missing tests or correcting existing tests

Usually you are going to use only the `fix` and the `feat` type.

For our project, the valid scopes are defined [here](https://github.com/enrique-lozano/Monekin/blob/main/docs/VALID_COMMIT_SCOPES.ts) along with a brief description of when to use them.

So, the final commit header (the first line of the commit, before the body and the footers) should look something like this:

```
<type>(<scope>): <short summary>
  │       │             │
  │       │             └─⫸ Summary in present tense. First letter capitalized. No period at the end.
  │       │
  │       └─⫸ Commit Scope: One of the defined in the VALID_COMMIT_SCOPES.ts
  │
  └─⫸ Commit Type: build|ci|docs|feat|fix|perf|refactor|test
```

If you have doubts you can check our [last commits](https://github.com/enrique-lozano/Monekin/commits/main) and see how they meet all of this conditions.

## Too much, right? 🤯

We know that following all this convention can be somewhat difficult, therefore, we provide you with tools so that you can carry it out:

### Husky

As you may have already read in the [Monekin Contribution Guide](https://github.com/enrique-lozano/Monekin/blob/main/docs/CODE_CONTRIBUTING.md), we use Husky to prevent anything wrong from being pushed to the repository. Well, this extension is also used to validate the messages of your commits before they are carried out. It will also indicate the errors about them, so that you can correct them easily. Examples:

![image](https://user-images.githubusercontent.com/61509169/207724827-e3d939e6-a98e-4782-bee6-39ee65e6587f.png)

![image](https://user-images.githubusercontent.com/61509169/207725733-443bf900-06b1-411e-b711-b6b62a1a4fec.png)

It can be seen that in the case of entering a valid commit, the instruction will be executed as normal:

![image](https://user-images.githubusercontent.com/61509169/207725987-ea037f49-9391-4ca5-849f-c40b99b29574.png)

### VSCode Extensions

- **Conventional Commits [[link](https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits)]**: With this great extension you can write your commit messages in the required format for this project easier. When you clone this repo, we provide the configuration for this extension that match with our requirements, so you don't have to do anything. You will see that our scopes appear automatically in the form when you run this extension. Check the link for more info on how to use it.
- **commitlint [[link](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint)]**: With this extension installed, you will have a linter for your commits in VSCode according with the requirements of Monekin.

![image](https://user-images.githubusercontent.com/61509169/207728724-7b67a415-b5cc-47f8-b2d0-32de97963e34.png)

## A final note 📝

Despite the fact that this convention is mandatory for this project and that it is very easy to carry out thanks to the aforementioned tools, we are not going to kill anyone who does not follow it to the letter.

What we want is that you feel comfortable collaborating, that you try, that you mess around and yes, also that you make mistakes. In the event that this convention is not followed in some of your pull requests, the worst thing that can happen to you is that we make a `squash commit`, that is, that we unify all your commits into one with a different message.
