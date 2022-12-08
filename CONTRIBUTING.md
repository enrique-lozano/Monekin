# Contributing to Monekin

First off, thank you for considering contributing to Monekin. It's people like you that make this application such a great tool.

In this article you will find information about the steps you should take to help us with the development of code for the application. Note that it also helps to [report bugs](https://github.com/enrique-lozano/Monekin/issues), participate in the [forum](https://github.com/enrique-lozano/Monekin/discussions) and in short, be active in our community!

## 1. Fork the repo

To start, fork the project. If you are new to this, don't worry! We leave you a guide below, and if you still have problems, you can contact us whenever you wish.

[How To Fork Guide by GitHub](https://docs.github.com/en/get-started/quickstart/fork-a-repo)

## 2. Choose what to do

You can see a list of tasks to do [here](https://github.com/enrique-lozano/Monekin/issues). Once you see one that suits you and is not assigned to anyone else, you can leave a comment on the task, so that other users and administrators know who is working on it.

If the list of tasks is too small for you, or you can't find one that suits you, here are some tips on how to help:

- Ask questions or suggest ideas in the comments section of any issue.
- Some recurring tasks such as adding new languages to the application, improving marketplace screenshots, or improving documentation do not usually have a related issue. These tasks are easy to perform, maybe you can start there.
- You can always make code improvements and pull requests without having an opened issue.
- You can create an issue about the thing that you consider to work on

## 3. Create a new working branch in your fork

Once you've decided on what you want to contribute it's time to create a new branch in your forked Monekin
repository.

    git checkout -b your-branch-name develop

> **NOTE**: You should replace `your-branch-name` with a good name to give to your branch. For example `fix/XXXX` where XXXX is the Issue number, or `feature/some-new-feature`.

This will be the branch in which you will code, make commits, etc.

`main` and `develop` branches are protected and only administrators can upload changes to them directly. All other users will have to make a Pull Request (step 4).

## 4. Submit a PR to `develop` branch

So far you should have pushed your work to your working branch and have tested that it works on all the compatible devices. Then final step is to open a pull request to the `develop` branch of the official [Monekin repo](https://github.com/enrique-lozano/Monekin).

[How To Submit a PR Guide by GitHub](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork)

### IMPORTANT:

- Make sure that on the base repository's base the `develop` branch is chosen as "base".
- Pull requests to `main` will be changed to the `develop` branch, or int wordt case, rejected.
