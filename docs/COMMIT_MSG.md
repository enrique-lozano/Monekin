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

For our project, the valid scopes are defined [here]().

So, the final commit header (the first line of the commit, before the body and the footers) should look something like this:

```
<type>(<scope>): <short summary>
  │       │             │
  │       │             └─⫸ Summary in present tense. First letter capitalized. No period at the end.
  │       │
  │       └─⫸ Commit Scope: One of the defined [here]()
  │
  └─⫸ Commit Type: build|ci|docs|feat|fix|perf|refactor|test
```

If you have doubts you can check our [last commits](https://github.com/enrique-lozano/Monekin/commits/main) and see how they meet all of this conditions.

## Too much, right? 🤯

We know that following all this convention can be somewhat difficult, therefore, we provide you with tools so that you can carry it out:

### Husky

As you may have already read in the [Monekin Contribution Guide](https://github.com/enrique-lozano/Monekin/blob/main/docs/CODE_CONTRIBUTING.md), we use Husky to prevent anything wrong from being pushed to the repository. Well, this extension is also used to validate the messages of your commits before they are carried out. It will also indicate the errors of the same, so that you can correct them easily.
