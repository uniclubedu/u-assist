import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ByocHeaderComponent } from './byoc-header.component';

describe('ByocHeaderComponent', () => {
  let component: ByocHeaderComponent;
  let fixture: ComponentFixture<ByocHeaderComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ByocHeaderComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ByocHeaderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
