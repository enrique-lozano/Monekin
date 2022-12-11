import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { BackupService } from 'src/app/services/backup/backup.service';
import { ToastService } from 'src/app/services/ionic/toast.service';

@Component({
  selector: 'app-import-data',
  templateUrl: './import-data.page.html',
  styleUrls: ['./import-data.page.scss'],
})
export class ImportDataPage implements OnInit {
  constructor(
    private router: Router,
    private backupService: BackupService,
    private toast: ToastService
  ) {}

  ngOnInit() {}

  importFile() {
    document.getElementById('file-input').click();
  }

  onFileSelected() {
    const filesUpload: any = document.querySelector('#file-input');

    if (filesUpload.files && filesUpload.files.length > 0) {
      const fileReader: FileReader = new FileReader();
      fileReader.readAsText(filesUpload.files[0]);
      fileReader.onload = async () => {
        if (fileReader.result) {
          this.backupService
            .importDataFromFile(fileReader.result)
            .then(() => {
              this.goToTabs();
            })
            .catch((err) => {
              this.toast.present('BACKUP.IMPORT.error', 'danger');
              console.error(err);
            });
        }
      };
    }
  }

  goToTabs() {
    this.router.navigate(['/tabs'], { replaceUrl: true });
  }
}
