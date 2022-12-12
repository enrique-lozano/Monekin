# Git/GitHub workflow

As a rule, you as a project collaborator should create working branches (fix/XXXX, feature/XXX....) starting from <code>develop</code>. When you have your collaboration ready, you must make a Pull Request to this branch. Below you have more information about the purpose of each branch.

## Branch resume

<table>
  <thead>
    <tr>
      <th>Branch name</th>
      <th>Description, instructions, notes...</th>
      <th>Protected</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>main</td>
      <td>Only accepts merges from <code>develop</code></td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>develop</td>
      <td>Accepts merges from the working branches (next row)</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>feature/XXXX, fix/XXXX....</td>
      <td>It originates from <code>develop</code>, and accepts and receives merges from it.</td>
      <td>No</td>
    </tr>
  </tbody>
</table>

### Branch main

The default branch of the app. Contains the code of the latest version of the application displayed in the application stores and in the launch section. It is only updated under two circumstances:

- **Merge/Pull request from the <code>develop</code> branch**: When this happens it means that a new version of the application will be created in the release section, and soon it will be available in the app stores.
- **Documentation update or CI/CD update**: Being quick changes that do not affect the deployed version of the app, it is allowed to make commits directly in this branch for this aspect (only for project admins). In this case, a new app version will not be created.

This is a protected branch, so no external code can enter it without the administrators' approval.

### Branch develop

Contains code ready to be deployed to the <code>main</code> branch. Changes to this branch are only accepted via Pull Request from the working branches. Administrators will also take care of keeping this branch updated with <code>main</code> branch

Each Pull Request made on this branch will be displayed as a separate item in the description of the version changes in the release section when the branch merges to <code>develop</code>.

Again, this is a protected branch, so no external code can enter it without the administrators' approval.

### Working branches

Branches where the entire development process is carried out, since as seen before, the other branches are only in charge of accepting merges/pull requests with few exceptions. Usually named <code>feature/xxxx</code> or <code>fix/xxxx</code>, but feel free to call them whatever you see fit. Once merged with develop they are deleted from the remote repository.
