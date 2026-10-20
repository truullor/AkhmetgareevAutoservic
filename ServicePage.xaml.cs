using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace AkhmetgareevAutoservic
{
    /// <summary>
    /// Логика взаимодействия для ServicePage.xaml
    /// </summary>
    public partial class ServicePage : Page
    {
        public ServicePage()
        {
            InitializeComponent();

            var currentServices = AkhmetgareevAutoserviceEntities.GetContext().Service.ToList();
            ServiceListView.ItemsSource = currentServices;

            ComboType.SelectedIndex = 0;

            UpdateServices();
        }
        private void TBoxSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateServices();
        }

        private void ComboType_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateServices();
        }

        private void RButtonUp_Checked(object sender, RoutedEventArgs e)
        {
            UpdateServices();
        }

        private void RButtonDown_Checked(object sender, RoutedEventArgs e)
        {
            UpdateServices();
        }



        private void UpdateServices()
        {
            var currentServices = AkhmetgareevAutoserviceEntities.GetContext().Service.ToList();

                if (ComboType.SelectedIndex == 0)
                {
                    currentServices = currentServices.Where(p => p.Discount >= 0 && p.Discount <= 100).ToList();
                }
                else if (ComboType.SelectedIndex == 1)
                {
                    currentServices = currentServices.Where(p => p.Discount >= 0 && p.Discount < 0.05).ToList();
                }
                else if (ComboType.SelectedIndex == 2)
                {
                    currentServices = currentServices.Where(p => p.Discount >= 0.05 && p.Discount < 0.15).ToList();
                }
                else if (ComboType.SelectedIndex == 3)
                {
                    currentServices = currentServices.Where(p => p.Discount >= 0.15 && p.Discount < 0.30).ToList();
                }
                else if (ComboType.SelectedIndex == 4)
                {
                    currentServices = currentServices.Where(p => p.Discount >= 0.30 && p.Discount < 0.70).ToList();
                }
                else if (ComboType.SelectedIndex == 5)
                {
                    currentServices = currentServices.Where(p => p.Discount >= 0.70 && p.Discount <= 1.00).ToList();
                }
            currentServices = currentServices.Where(p => p.Title.ToLower().Contains(TboxSearch.Text.ToLower())).ToList();

            if (RButtonDown.IsChecked.Value)
            {
                currentServices = currentServices.OrderByDescending(p => p.Cost).ToList();
            }
            if (RButtonUp.IsChecked.Value)
            {
                currentServices = currentServices.OrderBy(p => p.Cost).ToList();
            }

            ServiceListView.ItemsSource = currentServices;
        }


        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new AddEditPage());
        }

        private void ServiceListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }
    }
}