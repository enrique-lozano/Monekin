# Code contributions in Monekin

In this article you will find information about the steps you should take to help us with the development of code for the application.

## 1. Fork the repo

To start, fork the project. If you are new to this, don't worry! We leave you a guide below, and if you still have problems, you can contact us whenever you wish.

[How To Fork Guide by GitHub](https://docs.github.com/en/get-started/quickstart/fork-a-repo). After that you should [run your app](https://github.com/enrique-lozano/Monekin#installation) to check that everything is correct.

We work with code generation in some files, so make sure you take this into account before submitting any changes. To regenerate the files you can use:

```
dart run build_runner watch --delete-conflicting-outputs
```

If you work only with translations, you may want to use `dart run slang` instead, which regenerate the translations files faster.

## 2. Configure your developer workspace

Once you have the project up and running, you should prepare to develop in Monekin. To make changes to the project and develop on it, the use of Visual Studio Code as a text editor is strongly recommended. You can use any other code editor, you can even program using Word, but Visual Studio Code is the most widespread editor for Front-End development, and using it guarantees you follow the same work methods as the administrators of this project.

### Visual Studio and Recommended extensions

To increase your productivity on this project, it is strongly recommended to install the recommended extensions. To do this, when you have the project open with Visual Studio Code, you can type `@recommended` in the extensions section, and install all the ones that appear in the list.

<img src="https://user-images.githubusercontent.com/61509169/207661261-cbd2b2bd-7c7c-4d3a-a2e3-f4d65b5e2266.png"
width="300" hspace="10" vspace="10">

And that's it! You're are ready to start.

## 2. Choose what to do

You can see a list of tasks to do [here](https://github.com/enrique-lozano/Monekin/issues). Once you see one that suits you and is not assigned to anyone else, you can leave a comment on the task, so that other users and administrators know who is working on it.

We especially appreciate help with [issues tagged as "help-wanted"](https://github.com/enrique-lozano/Monekin/issues?q=is%3Aopen+is%3Aissue+label%3A%22help+wanted%22), as these are tasks that we are unable to solve due to not having enough experience or knowledge to do so.

New or inexperienced developers can go for [issues tagged as "good-first-issue"](https://github.com/enrique-lozano/Monekin/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22), as these are easier to tackle and are a great way to start getting familiar with the app's code.

If the list of tasks is too small for you, or you can't find one that suits you, here are some tips on how to help:

- You can create an issue about the thing that you consider to work on.
- You can always make code improvements and pull requests without having an opened issue.
- Ask questions or suggest ideas in the comments section of any issue.
- Some recurring tasks such as [adding new languages to Monekin](https://github.com/enrique-lozano/Monekin/blob/main/docs/I18N_CONTRIBUTING.md), improving marketplace screenshots, or improving documentation do not usually have a related issue. These tasks are easy to perform, maybe you can start there.

## 3. Create a new working branch in your fork

Once you've decided on what you want to contribute it's time to create a new branch in your forked Monekin
repository.

    git checkout -b your-branch-name develop

> **NOTE**: You should replace `your-branch-name` with a good name to give to your branch. For example `fix/XXXX` where XXXX is the Issue number, or `feature/some-new-feature`.

This will be the branch in which you will code, make commits, etc. Before start coding it **is strongly recommended to read the [git branch workflow](https://github.com/enrique-lozano/Monekin/blob/main/docs/GIT_BRANCHES_WORKFLOW.md) and the [commit message convention](https://github.com/enrique-lozano/Monekin/blob/main/docs/COMMIT_MSG.md) that we use in this project**.

`main` and `develop` branches are protected and only administrators can upload changes to them directly. All other users will have to make a Pull Request (step 4).

## 4. Submit a PR to `develop` branch

So far you should have pushed your work to your working branch and have tested that it works on all the compatible devices. Then final step is to open a pull request to the `develop` branch of the official [Monekin repo](https://github.com/enrique-lozano/Monekin).

[How To Submit a PR Guide by GitHub](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork)

### IMPORTANT:

- Make sure that on the base repository's base the `develop` branch is chosen as "base".
- Pull requests to `main` will be changed to the `develop` branch, or in the worst case, rejected.
