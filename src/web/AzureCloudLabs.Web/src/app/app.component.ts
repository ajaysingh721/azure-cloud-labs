import { Component, inject, OnInit, Pipe, PipeTransform } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { MatInputModule } from '@angular/material/input';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { MatButtonModule, MatIconButton } from '@angular/material/button';
import { MatRipple, MatRippleModule } from '@angular/material/core';
import { MatIconModule } from '@angular/material/icon';
import { SnakbarComponent } from './shared/components/snakbar/snakbar.component';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-root',
  imports: [
    RouterOutlet,
    MatInputModule,
    CommonModule,
    ReactiveFormsModule,
    MatButtonModule,
    MatRippleModule,
    MatIconModule,
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
})
export class AppComponent implements OnInit {
  title = 'web';
  fb: FormBuilder;
  form!: FormGroup;
  durationInSeconds = 2;

  constructor(fb: FormBuilder, private _snackBar: MatSnackBar) {
    this.fb = fb;
  }

  ngOnInit() {
    // Add form controls for Client ID, Client Secret, Subscription ID and Tenant ID
    this.form = this.fb.group({
      clientId: [''],
      clientSecret: [''],
      subscriptionId: [''],
      tenantId: ['84f1e4ea-8554-43e1-8709-f0b8589ea118'],
      acccessKey: [''],
    });
  }

  // Function to submit the form
  onSubmit() {
    console.log(this.form.value);
  }

  // Copy to clipboard command

  azCredentialCopyToClipboard() {
    const el = document.createElement('textarea');
    el.value =
      'AZURE_CLIENT_ID=' +
      this.form.value.clientId +
      '\n' +
      'AZURE_CLIENT_SECRET=' +
      this.form.value.clientSecret +
      '\n' +
      'AZURE_SUBSCRIPTION_ID=' +
      this.form.value.subscriptionId +
      '\n' +
      'AZURE_TENANT_ID=' +
      this.form.value.tenantId +
      '\n' +
      'AZURE_ACCESS_KEY=' +
      this.form.value.acccessKey +
      '\n' +
      'AZURE_CREDENTIALS=' +
      JSON.stringify(this.form.value);

    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
    this._snackBar.openFromComponent(SnakbarComponent, {
      duration: this.durationInSeconds * 1000,
    });
  }

  // Copy to clipboard div html element
  azLoginCopyToClipboard() {
    const el = document.createElement('textarea');
    el.value =
      'az login --service-principal -u ' +
      this.form.value.clientId +
      ' -p ' +
      this.form.value.clientSecret +
      ' --tenant ' +
      this.form.value.tenantId;

    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
    this._snackBar.openFromComponent(SnakbarComponent, {
      duration: this.durationInSeconds * 1000,
    });
  }
}
