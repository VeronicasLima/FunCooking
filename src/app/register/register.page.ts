import { Component, OnInit } from '@angular/core';
import { FormBuilder,FormGroup,Validators } from '@angular/forms';

@Component({
  selector: 'app-register',
  templateUrl: './register.page.html',
  styleUrls: ['./register.page.scss'],
  standalone: false,
})
export class RegisterPage implements OnInit {

    registerForm!:FormGroup;
    registerError:string ='';

  constructor(private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.registerForm = this.formBuilder.group({
      nome: ['',Validators.required],

      email: ['',[
        Validators.required,
        Validators.email
      ]],

      password:['',[
        Validators.required,
        Validators.minLength(6)
      ]],
    });

    this.registerForm.valueChanges.subscribe(() => {
      this.registerError='';
    });
  }

  register() {

    this.registerError = '';

    if (this.registerForm.invalid) {
      this.registerForm.markAllAsTouched();

      this.registerError =
        'Verifica os dados introduzidos.A palavra-passe deve ter pelo menos 6 carateres.';

        return;
    }

    this.registerError =
      'O registo ainda não está disponível.';
  }
}
