import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashboardUComponent } from './dashboard-u.component';

describe('DashboardUComponent', () => {
  let component: DashboardUComponent;
  let fixture: ComponentFixture<DashboardUComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DashboardUComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardUComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
