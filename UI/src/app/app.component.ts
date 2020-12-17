import { Component, OnInit, OnDestroy } from '@angular/core';
import { ByocService } from './core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit, OnDestroy {
  title = 'dev-cloud';
  constructor(
    private byocService: ByocService
  ) {}

  ngOnInit() {
    this.byocService.get('').subscribe(
      
    );
  }

  ngOnDestroy() {

  }

}
